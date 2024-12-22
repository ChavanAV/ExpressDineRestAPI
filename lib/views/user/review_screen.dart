import 'dart:convert';

import 'package:express_dine_rest_api/models/menu_model.dart';
import 'package:express_dine_rest_api/models/order_model.dart';
import 'package:express_dine_rest_api/network/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/button.dart';
import '../../widgets/decoration.dart';
import '../../widgets/my_card.dart';
import '../../widgets/toast_msg.dart';

class ReviewScreen extends StatefulWidget {
  final Menu menu;
  final String userName;
  final double totalPrice;
  final int quantity;
  final String trainName;
  final String compartment;
  final String seatNo;
  final int contactNo;
  final int uid;
  final int hid;
  const ReviewScreen({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.quantity,
    required this.trainName,
    required this.compartment,
    required this.seatNo,
    required this.contactNo,
    required this.uid,
    required this.hid,
    required this.menu,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool isLoading = false;

  void _showMenuDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              "Once your order placed, it cannot be deleted, \nclick Yes to proceed",
              style: foodNameTextStyle),
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: () {
                  sendOrder();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
          ],
        );
      },
    );
  }

  void sendOrder() async {
    setState(() {
      isLoading = true;
    });
    try {
      final orderModel = Order(
        quantity: widget.quantity,
        totalPrice: widget.totalPrice,
        trainName: widget.trainName,
        compartment: widget.compartment,
        seatNo: widget.seatNo,
        contactNo: widget.contactNo,
        date: DateTime.now(),
      );
      var url = Uri.parse(
          '${API.saveOrder}/${widget.uid}/${widget.menu.mid}/${widget.hid}');
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderModel.toJson()),
      );
      debugPrint('res : ${res.body}');
      if (res.statusCode == 201) {
        setState(() {
          isLoading = false;
        });
        final resBody = jsonDecode(res.body);
        final saved = resBody['data'];
        if (saved) {
          showSnac("Your order has been placed successfully.");
          if (mounted) {
            Navigator.of(context)
              ..pop()
              ..pop();
          }
        } else {
          showSnac("Your order not placed, try again");
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showSnac("Something went wrong.");
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
      showSnac("Something went wrong, try again.");
    }
  }

  void showSnac(content) {
    Utils().showSnacBar(context, content);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Your order"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            MyCard(
                padding: myCardPadding,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            MemoryImage(base64Decode(widget.menu.image!)),
                        backgroundColor: allBgClr,
                      ),
                      Text(widget.menu.dishName, style: foodNameTextStyle),
                      Text(
                        widget.menu.price.toString(),
                        style: cardNameTextStyle,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quantity: ${widget.quantity}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text("Total Amount: ${widget.totalPrice}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
                width: double.maxFinite,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MyElevatedButton(
                    btnName: (!isLoading)
                        ? const Text("Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600))
                        : const CircularProgressIndicator(color: Colors.white),
                    press: () {
                      _showMenuDeleteDialog();
                    }))
          ],
        ),
      ),
    );
  }
}
