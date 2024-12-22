import 'package:express_dine_rest_api/dao/hotel_dao.dart';
import 'package:express_dine_rest_api/dto/hotel_dto.dart';
import 'package:express_dine_rest_api/providers/user_provider.dart';
import 'package:express_dine_rest_api/views/admin/update_restaurant.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../widgets/decoration.dart';
import '../../widgets/toast_msg.dart';
import 'add_item_screen.dart';
import 'all_items_screen.dart';
import 'all_orders_screen.dart';
import 'order_tab_view.dart';

class AdminHomeScreen extends StatefulWidget {
  final User user;
  const AdminHomeScreen({super.key, required this.user});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isRegistering = false;
  bool loading = false;

  final HotelDao _hotelDao = HotelDao();
  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<HotelDto?> getHotelDetails() async {
    return await _hotelDao.getHotelDetails(widget.user.uid!);
  }

  Future<void> openCloseHotel(HotelDto hotel) async {
    setState(() {
      isRegistering = false;
    });
    bool isOpen = hotel.isOpen;
    final res = await _hotelDao.openCloseHotel(!isOpen, hotel.hid);
    if (res == true) {
      setState(() {
        isRegistering = false;
      });
      resOpenClose(isOpen);
    } else {
      setState(() {
        isRegistering = false;
      });
      showSnac("Something went wrong, try again!!!");
    }
  }

  showSnac(content) {
    Utils().showSnacBar(context, content);
  }

  resOpenClose(bool isOpen) {
    // Navigator.pop(context);
    (isOpen)
        ? showSnac(
            "Your restaurant is closed, you never get order by any consumers, "
            "however you will get order when it will open.")
        : showSnac(
            "Your restaurant is opened, you can start supplying orders.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<HotelDto?>(
          future: getHotelDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("something went wrong");
            } else if (!snapshot.hasData) {
              return const Text("No data found");
            }
            HotelDto hotel = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  hotel.hotelName,
                  style: stationTextStyle,
                ),
                centerTitle: true,
                backgroundColor: allBgClr,
                elevation: 0,
                bottom: TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(text: 'Orders'),
                    Tab(text: 'Menus'),
                    Tab(text: 'Add Menu'),
                  ],
                ),
              ),
              drawer: SafeArea(
                child: Drawer(
                  backgroundColor: allBgClr,
                  width: 270,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            color: orangeBtnClr),
                        margin: EdgeInsets.zero,
                        currentAccountPicture: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/logo.jpg"),
                        ),
                        accountName: Text(hotel.hotelName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black)),
                        accountEmail: const Text(""),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateRestaurant(
                                  hotel: hotel,
                                  user: widget.user,
                                ),
                              ));
                        },
                        title: const Text("Update Restaurant",
                            style: TextStyle(fontSize: 16)),
                        leading: const Icon(Icons.edit_note, size: 30),
                        iconColor: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllOrdersScreen(hid: hotel.hid),
                              ));
                        },
                        title: const Text("All Orders",
                            style: TextStyle(fontSize: 16)),
                        leading: const Icon(Icons.update),
                        iconColor: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          openCloseHotel(hotel);
                        },
                        title: (!isRegistering)
                            ? ((hotel.isOpen)
                                ? const Text("Close Restaurant",
                                    style: TextStyle(fontSize: 16))
                                : const Text("Open Restaurant",
                                    style: TextStyle(fontSize: 16)))
                            : LinearProgressIndicator(color: orangeBtnClr),
                        leading: const Icon(Icons.restaurant),
                        iconColor: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          _userProvider.logout(context);
                        },
                        title: const Text("Logout",
                            style: TextStyle(fontSize: 16)),
                        leading: const Icon(Icons.logout),
                        iconColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: allBgClr,
              body: TabBarView(
                controller: _tabController,
                children: [
                  OrderTabView(hid: hotel.hid),
                  AllItemsScreen(hid: hotel.hid),
                  AddItemScreen(hid: hotel.hid),
                ],
              ),
            );
          }),
    );
  }
}
