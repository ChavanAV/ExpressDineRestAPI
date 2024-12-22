import 'dart:convert';

import 'package:express_dine_rest_api/dao/hotel_dao.dart';
import 'package:express_dine_rest_api/dao/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/hotel_model.dart';
import '../../models/user_model.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import '../../widgets/data_input_field.dart';
import '../../widgets/decoration.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> restaurantFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final hotelNameController = TextEditingController();
  final stationNameController = TextEditingController();
  final hotelAddressController = TextEditingController();
  final roleItems = ['No', 'Yes'];
  String defaultRole = 'No';
  bool isRegistering = false;
  bool obscure = false;

  final UserDao _userDao = UserDao();
  final HotelDao _hotelDao = HotelDao();

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  void registerUser(User user) async {
    setState(() {
      isRegistering = true;
    });
    try {
      final res = await _userDao.saveUser(user);
      if (res!.statusCode == 201) {
        setState(() {
          isRegistering = false;
        });
        var resBody = json.decode(res.body);
        if (resBody['data'] != null) {
          Fluttertoast.showToast(msg: "User registered!!!");
          if (defaultRole == 'No') {
            setState(() {
              userNameController.clear();
              pinController.clear();
            });
            navBack();
          }
        } else {
          Fluttertoast.showToast(msg: "Sign Up Again");
          setState(() {
            isRegistering = false;
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        isRegistering = false;
      });
    }
  }

  void navBack() {
    Navigator.pop(context);
  }

  void registerHotelWithUser(User user) async {
    setState(() {
      isRegistering = true;
    });
    Hotel hotelModel = Hotel(
      user: user,
      hotelName: hotelNameController.text,
      hotelAdd: hotelAddressController.text,
      stationName: stationNameController.text,
      isOpen: true,
    );
    try {
      var res = await _hotelDao.registerHotelWithUser(hotelModel);
      if (res?.statusCode == 201) {
        setState(() {
          isRegistering = false;
          defaultRole = 'No';
        });
        var resBody = json.decode(res!.body);
        if (resBody['data'] != null) {
          Fluttertoast.showToast(msg: "Registration successful!!!");
          setState(() {
            hotelAddressController.clear();
            hotelNameController.clear();
            stationNameController.clear();
            userNameController.clear();
            pinController.clear();
            isRegistering = false;
          });
          navBack();
        } else {
          Fluttertoast.showToast(msg: "Sign Up Again");
          setState(() {
            isRegistering = false;
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Sign Up Again");
      setState(() {
        isRegistering = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    pinController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // restaurantNameController.dispose();
    stationNameController.dispose();
    // restaurantAddressController.dispose();
  }

  DropdownMenuItem<String> buildItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.orange),
      ));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataInput(
                      labelText: "Enter user name",
                      controller: userNameController,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    DataInput(
                        labelText: "Enter password",
                        controller: pinController,
                        obscureText: !obscure),
                    SizedBox(
                      height: size.height * 0.001,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: const Text("Show password")),
                  ],
                ),
              )),
          SizedBox(
            height: size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Text("Want to register restaurant?  ",
                    style: TextStyle(fontSize: 16)),
                DropdownButton(
                  value: defaultRole,
                  items: roleItems.map(buildItem).toList(),
                  onChanged: (value) => setState(() {
                    defaultRole = value!;
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          (defaultRole == 'Yes')
              ? Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.all(10),
                  decoration: decoration,
                  child: Form(
                    key: restaurantFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataInputCard(
                          name: "Restaurant Name",
                          controller: hotelNameController,
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
                          controller: hotelAddressController,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            height: 45,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: MyElevatedButton(
                btnName: !isRegistering
                    ? Text(
                        "Register",
                        style: myElevatedButtonInnerTextStyle,
                      )
                    : const CircularProgressIndicator(color: Colors.white),
                press: () {
                  if (_formKey.currentState!.validate()) {
                    User user = User(
                      userName: userNameController.text,
                      password: pinController.text,
                      role: defaultRole,
                    );
                    (defaultRole == 'Yes')
                        ? registerHotelWithUser(user)
                        : registerUser(user);
                  }
                }),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ?"),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login")),
            ],
          ),
        ]),
      ),
    );
  }
}
