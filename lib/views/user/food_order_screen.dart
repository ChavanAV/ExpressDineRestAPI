import 'package:express_dine_rest_api/models/menu_model.dart';
import 'package:express_dine_rest_api/views/user/review_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import '../../widgets/decoration.dart';
import '../../widgets/toast_msg.dart';

class FoodOrderScreen extends StatefulWidget {
  final double totalPrice;
  final int quantity;
  final int hid;
  final int uid;
  final Menu menu;
  const FoodOrderScreen({
    super.key,
    required this.totalPrice,
    required this.quantity,
    required this.hid,
    required this.menu,
    required this.uid,
  });

  @override
  State<FoodOrderScreen> createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final trainController = TextEditingController();
  final compartmentController = TextEditingController();
  final seatController = TextEditingController();
  final phoneController = TextEditingController();
  final double textAndTextFieldHeight = 45;

  void proceedOrder() {
    if (_formKey.currentState!.validate() &&
        (userNameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(userNameController.text)) &&
        (trainController.text.isNotEmpty) &&
        (compartmentController.text.isNotEmpty) &&
        (seatController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(seatController.text)) &&
        (phoneController.text.isNotEmpty &&
            RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phoneController.text))) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewScreen(
              totalPrice: widget.totalPrice,
              quantity: widget.quantity,
              hid: widget.hid,
              uid: widget.uid,
              userName: userNameController.text.toString(),
              trainName: trainController.text.toString(),
              compartment: compartmentController.text.toString(),
              seatNo: seatController.text.toString(),
              contactNo: int.parse(phoneController.text),
              menu: widget.menu,
            ),
          ));
    } else {
      Utils().showSnacBar(context, "Enter all correct details");
    }
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    trainController.dispose();
    compartmentController.dispose();
    phoneController.dispose();
    seatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Location Information"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Name:",
                  controller: userNameController,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Your Train:",
                  controller: trainController,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Your Compartment:",
                  controller: compartmentController,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                DataInputCard(
                  name: "Your seat no:",
                  height: textAndTextFieldHeight,
                  keyBoardType: TextInputType.number,
                  controller: seatController,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                DataInputCard(
                  name: "Phone Number:",
                  height: 60,
                  controller: phoneController,
                  helperText: "Enter 10 digit number",
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: MyElevatedButton(
                      btnName: const Text("Proceed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      press: () {
                        proceedOrder();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ReviewScreen(
                        //         uid: widget.uid,
                        //       ),
                        //     ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
