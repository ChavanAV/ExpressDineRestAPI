import 'package:express_dine_rest_api/dao/menu_dao.dart';
import 'package:express_dine_rest_api/views/user/food_description_screen.dart';
import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import '../../widgets/decoration.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/toast_msg.dart';
import 'allImgCard.dart';

class RestaurantInfoScreen extends StatefulWidget {
  final int hid;
  final int uid;
  final String restaurantName;
  final bool isRestaurantOpen;
  const RestaurantInfoScreen(
      {super.key,
      required this.hid,
      required this.restaurantName,
      required this.uid,
      required this.isRestaurantOpen});

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  TextEditingController searchController = TextEditingController();
  List<Menu> menusList = [];
  List<Menu> filteredList = [];
  final MenuDao _menuDao = MenuDao();
  late Future<List<Menu>> _future;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _future = fetchMenus(widget.hid);
  }

  Future<List<Menu>> fetchMenus(int hid) async {
    try {
      final menus = await _menuDao.fetchMenus(hid);
      if (menus != null) {
        setState(() {
          menusList = menus;
          filteredList.addAll(menusList);
        });
        return menus;
      } else {
        showSnac();
        return [];
      }
    } catch (e) {
      showSnac();
      return [];
    }
  }

  void showSnac() {
    Utils().showSnacBar(context, "Something went wrong !!!");
  }

  void filterData(String searchText) {
    setState(() {
      filteredList = menusList
          .where((menu) =>
              menu.dishName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.restaurantName),
      backgroundColor: allBgClr,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySearchBar(
            searchController: searchController,
            hintText: "Search food",
            onChanged: filterData,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Our menu",
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
          FutureBuilder<List<Menu>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("No data found"));
              } else {
                List<Menu> specialMenus = [];
                specialMenus =
                    filteredList.where((menu) => menu.isSpecial).toList();
                return Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: GridView.builder(
                      itemCount: filteredList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 2.7),
                      itemBuilder: (context, index) {
                        final menu = filteredList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDescriptionScreen(
                                    menu: menu,
                                    isRestaurantOpen: widget.isRestaurantOpen,
                                    uid: widget.uid,
                                    hid: widget.hid,
                                    specialMenus: specialMenus,
                                  ),
                                ));
                          },
                          child: AllImgCard(
                            img: menu.image!,
                            itemName: menu.dishName,
                            itemPrice: menu.price,
                            time: menu.duration,
                            available: menu.isAvail,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
