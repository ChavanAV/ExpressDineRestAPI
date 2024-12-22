import 'dart:convert';

import 'package:express_dine_rest_api/views/admin/update_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/menu_model.dart';
import '../../network/endpoints.dart';
import '../../widgets/decoration.dart';
import '../../widgets/toast_msg.dart';
import '../user/allImgCard.dart';

class AllItemsScreen extends StatefulWidget {
  final int hid;

  const AllItemsScreen({super.key, required this.hid});

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  late Future<List<Menu>> _menus;

  @override
  void initState() {
    super.initState();
    _menus = fetchMenus(widget.hid);
  }

  Future<List<Menu>> fetchMenus(int hid) async {
    try {
      final response = await http.get(Uri.parse('${API.allMenu}/$hid'));
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['data'];
        debugPrint("fetching menus : $data");
        return data.map((menu) => Menu.fromJson(menu)).toList();
      } else {
        showSnac();
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching menus: $e");
      showSnac();
      return [];
    }
  }

  void showSnac() {
    Utils().showSnacBar(context, "Something went wrong !!!");
  }

  Future<void> _refreshData() async {
    setState(() {
      _menus = fetchMenus(widget.hid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<Menu>>(
        future: _menus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            debugPrint("Error in FutureBuilder: ${snapshot.error}");
            return Center(
              child: Text(
                'Something went wrong. Please try again!',
                style: stationTextStyle,
              ),
            );
          }

          final menus = snapshot.data ?? [];

          if (menus.isEmpty) {
            return Center(
              child: Text(
                "No Data Found!",
                style: stationTextStyle,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: GridView.builder(
              itemCount: menus.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.7,
              ),
              itemBuilder: (context, index) {
                final menu = menus[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateItemScreen(menu: menu),
                    ),
                  ),
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
          );
        },
      ),
    );
  }
}
