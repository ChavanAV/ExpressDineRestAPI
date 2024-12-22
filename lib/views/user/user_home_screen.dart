import 'package:express_dine_rest_api/dao/hotel_dao.dart';
import 'package:express_dine_rest_api/dto/hotel_dto.dart';
import 'package:express_dine_rest_api/providers/user_provider.dart';
import 'package:express_dine_rest_api/views/user/restaurant_items_screen.dart';
import 'package:express_dine_rest_api/views/user/user_order_history_screen.dart';
import 'package:express_dine_rest_api/widgets/my_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/decoration.dart';
import '../../widgets/search_bar.dart';

class UserHomeScreen extends StatefulWidget {
  final int uid;
  const UserHomeScreen({super.key, required this.uid});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<HotelDto> hotelList = [];
  List<HotelDto> filteredList = [];
  final HotelDao _hotelDao = HotelDao();
  final UserProvider _userProvider = UserProvider();
  late Future<void> _getAllHotels;

  @override
  void initState() {
    super.initState();
    _getAllHotels = getAllHotelInfo();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> getAllHotelInfo() async {
    final responseData = await _hotelDao.getAllHotelInfo();
    setState(() {
      hotelList = responseData!;
      filteredList.addAll(hotelList);
    });
  }

  void filterData(String searchText) {
    setState(() {
      filteredList = hotelList
          .where((hotel) => hotel.stationName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar("Train Food"),
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
                  accountName: const Text("Enjoy your journey",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  accountEmail: const Text(""),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserOrderHistoryScreen(uid: widget.uid),
                        ));
                  },
                  title:
                      const Text("My Orders", style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.brunch_dining_sharp),
                  iconColor: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    _userProvider.logout(context);
                  },
                  title: const Text("Logout", style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.logout),
                  iconColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: allBgClr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySearchBar(
              searchController: searchController,
              hintText: "Search stations",
              onChanged: (p0) => filterData(p0),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Explore Food",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 260.0, left: 10),
              child: Divider(
                color: Colors.black,
                thickness: 3,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder(
              future: _getAllHotels,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("No data found"));
                } else {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      HotelDto hotel = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantInfoScreen(
                                  hid: hotel.hid,
                                  restaurantName: hotel.hotelName,
                                  uid: widget.uid,
                                  isRestaurantOpen: hotel.isOpen,
                                ),
                              ));
                        },
                        child: MyCard(
                            padding: myCardPadding,
                            child: ListTile(
                              title: Text(
                                hotel.stationName,
                                style: stationTextStyle,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel.hotelName,
                                  ),
                                  (hotel.isOpen != true)
                                      ? Text(
                                          "Restaurant temporary closed",
                                          style: restaurantAvailableTextStyle,
                                        )
                                      : Container(),
                                ],
                              ),
                              trailing: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      "assets/images/restaurant.png")),
                            )),
                      );
                    },
                  ));
                }
              },
            ),
          ],
        ));
  }
}
