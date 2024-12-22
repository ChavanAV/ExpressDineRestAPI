import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/menu_model.dart';
import '../../widgets/button.dart';
import '../../widgets/decoration.dart';
import '../../widgets/toast_msg.dart';
import 'allImgCard.dart';
import 'food_order_screen.dart';

class FoodDescriptionScreen extends StatefulWidget {
  final Menu menu;
  final int uid;
  final int hid;
  final bool isRestaurantOpen;
  final List<Menu> specialMenus;
  const FoodDescriptionScreen({
    super.key,
    required this.menu,
    required this.isRestaurantOpen,
    required this.uid,
    required this.hid,
    required this.specialMenus,
  });

  @override
  State<FoodDescriptionScreen> createState() => _FoodDescriptionScreenState();
}

class _FoodDescriptionScreenState extends State<FoodDescriptionScreen> {
  int quantity = 1;
  double? totalPrice;

  void _increaseQuantity() {
    totalPrice = widget.menu.price;
    setState(() {
      quantity++;
      totalPrice = totalPrice! * quantity;
    });
  }

  void _decreaseQuantity() {
    totalPrice = widget.menu.price;
    setState(() {
      if (quantity > 1) {
        quantity--;
        totalPrice = totalPrice! * quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9E8E8),
        elevation: 0,
      ),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              decoration: const BoxDecoration(color: Color(0xFFE9E8E8)),
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 150,
                backgroundColor: allBgClr,
                backgroundImage: MemoryImage(base64Decode(widget.menu.image!)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.menu.dishName,
                    style: TextStyle(
                        color: orangeTextClr,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  (!widget.menu.isAvail)
                      ? Text(
                          "Currently Unavailable",
                          style: itemAvailableTextStyle,
                        )
                      : Container(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs ${widget.menu.price}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: orangeBtnClr,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                _decreaseQuantity();
                              },
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _increaseQuantity();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "This dish will be delivered in ${widget.menu.duration} minutes",
                    style: const TextStyle(
                        color: Color(0xFF474E68),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.menu.description,
                    style: const TextStyle(
                        color: Color(0xFF474E68),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(color: Colors.black, thickness: 1),
                  const Text(
                    "Recommended Items",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: 250,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: GridView.builder(
                  itemCount: widget.specialMenus.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 2.7),
                  itemBuilder: (context, index) {
                    final menu = widget.specialMenus[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDescriptionScreen(
                                menu: menu,
                                isRestaurantOpen: widget.isRestaurantOpen,
                                uid: widget.uid,
                                hid: widget.hid,
                                specialMenus: widget.specialMenus,
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
            ),
            SizedBox(width: size.width, height: 100, child: Container()),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: const Color(0xFFE9E8E8),
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              (totalPrice == null)
                  ? "Total Rs ${widget.menu.price} "
                  : "Total Rs $totalPrice ",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: size.width * 0.3,
              height: 35,
              child: MyElevatedButton(
                  btnName: const Text("Order",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  press: () {
                    (!widget.menu.isAvail)
                        ? Utils().showSnacBar(
                            context, "Currently this item is not available")
                        : (!widget.isRestaurantOpen)
                            ? Utils().showSnacBar(
                                context, "Restaurant temporarily closed")
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodOrderScreen(
                                          totalPrice: (totalPrice == null)
                                              ? widget.menu.price
                                              : totalPrice!,
                                          quantity: quantity,
                                          hid: widget.hid,
                                          menu: widget.menu, uid: widget.uid,
                                          // uid: widget.filteredList['uid']),
                                        )));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
