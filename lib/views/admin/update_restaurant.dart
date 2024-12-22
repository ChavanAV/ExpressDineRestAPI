import 'dart:convert';

import 'package:express_dine_rest_api/dto/hotel_dto.dart';
import 'package:express_dine_rest_api/models/user_model.dart';
import 'package:express_dine_rest_api/views/admin/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../network/endpoints.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import '../../widgets/decoration.dart';
import '../../widgets/toast_msg.dart';

class UpdateRestaurant extends StatefulWidget {
  final HotelDto hotel;
  final User user;
  const UpdateRestaurant({super.key, required this.hotel, required this.user});

  @override
  State<UpdateRestaurant> createState() => _UpdateRestaurantState();
}

class _UpdateRestaurantState extends State<UpdateRestaurant> {
  final GlobalKey<FormState> restaurantFormKey = GlobalKey<FormState>();
  final restaurantNameController = TextEditingController();
  final stationNameController = TextEditingController();
  final restaurantAddressController = TextEditingController();
  bool loading = false;
  bool obscure = false;

  @override
  void initState() {
    super.initState();
    restaurantNameController.text = widget.hotel.hotelName;
    stationNameController.text = widget.hotel.stationName;
    restaurantAddressController.text = widget.hotel.hotelAdd;
  }

  Future<void> updateRestaurant() async {
    print("update hotel Started");
    if (restaurantFormKey.currentState!.validate() &&
        (restaurantNameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$')
                .hasMatch(restaurantNameController.text)) &&
        (stationNameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$').hasMatch(stationNameController.text)) &&
        (restaurantAddressController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$')
                .hasMatch(restaurantAddressController.text))) {
      setState(() {
        loading = true;
      });
      try {
        final url = Uri.parse(API.updateHotel);
        final hotelModel = HotelDto(
          hid: widget.hotel.hid,
          hotelName: restaurantNameController.text.toString(),
          hotelAdd: restaurantAddressController.text.toString(),
          stationName: stationNameController.text.toString(),
          isOpen: widget.hotel.isOpen,
        );
        final res = await http.put(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(hotelModel.toJson()),
        );
        if (res.statusCode == 200) {
          final resBody = jsonDecode(res.body);
          if (resBody['data'] != null) {
            setState(() {
              loading = false;
              restaurantNameController.clear();
              restaurantAddressController.clear();
              stationNameController.clear();
            });
            navToAdminScreen();
          } else {
            setState(() {
              loading = false;
            });
            showSnac("Data not found, try again!!!");
          }
        } else {
          setState(() {
            loading = false;
          });
          showSnac("Some error occurred, try again!!!");
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        // print(e);
        showSnac("Something went wrong, try again!!! ");
      }
    }
  }

  void showSnac(content) {
    Utils().showSnacBar(context, content);
  }

  void navToAdminScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHomeScreen(user: widget.user),
        ),
        (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    restaurantNameController.dispose();
    stationNameController.dispose();
    restaurantAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Update Restaurant"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(10),
            decoration: decoration,
            child: Form(
              key: restaurantFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataInputCard(
                    name: "Restaurant Name",
                    controller: restaurantNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DataInputCard(
                    name: "Railway Station Name",
                    controller: stationNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DataInputCard(
                    name: "Address",
                    controller: restaurantAddressController,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SizedBox(
                    height: 45,
                    width: size.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyElevatedButton(
                        btnName: !loading
                            ? Text(
                                "Update",
                                style: myElevatedButtonInnerTextStyle,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white),
                        press: () {
                          updateRestaurant();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
