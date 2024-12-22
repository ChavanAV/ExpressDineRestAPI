import 'package:flutter/material.dart';

Color allBgClr = const Color(0xFFF4F4F2);
Color orangeTextClr = const Color(0xFFFF8E6E);
Color orangeSurfaceClr = const Color(0xFFFF8E6E);
Color orangeBtnClr = const Color(0xFFFF8E6E);
Color orderCardClr = const Color(0xFFF1F6F9);
Color cardBgClr = Colors.white;

const double myCardPadding = 10;
const double myCardMargin = 10;

TextStyle stationTextStyle =
    TextStyle(fontSize: 18, color: orangeTextClr, fontWeight: FontWeight.w400);
TextStyle foodNameTextStyle =
    TextStyle(fontSize: 18, color: orangeTextClr, fontWeight: FontWeight.w400);
TextStyle foodPriceTextStyle = const TextStyle(
    fontSize: 16, color: Color(0xFF000000), fontWeight: FontWeight.w400);
TextStyle foodTimeTextStyle = const TextStyle(
    fontSize: 14, color: Color(0xFF73777B), fontWeight: FontWeight.w400);
TextStyle cardNameTextStyle = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black);
TextStyle cardDateTimeTextStyle = const TextStyle(
    color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400);
TextStyle orderCardItemNameTextStyle =
    TextStyle(color: orangeTextClr, fontSize: 16, fontWeight: FontWeight.w400);
TextStyle itemAvailableTextStyle =
    TextStyle(fontSize: 12, color: orangeTextClr, fontWeight: FontWeight.w400);
TextStyle restaurantAvailableTextStyle =
    TextStyle(fontSize: 14, color: orangeTextClr, fontWeight: FontWeight.w400);

MaterialStateProperty<OutlinedBorder?> regularStyle = MaterialStatePropertyAll(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

AppBar myAppBar(text) => AppBar(
      title: Text(
        text,
        style: stationTextStyle,
      ),
      centerTitle: true,
      backgroundColor: allBgClr,
      elevation: 0,
    );
TextStyle myElevatedButtonInnerTextStyle = const TextStyle(
    fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white);
EdgeInsets btnTextFieldPadding = const EdgeInsets.symmetric(horizontal: 15);
TextStyle cardInfoTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.black.withOpacity(.7),
    fontWeight: FontWeight.w400);
TextStyle orderCardTotalPriceTextStyle = const TextStyle(
    fontSize: 16, color: Colors.green, fontWeight: FontWeight.w400);

Decoration decoration = BoxDecoration(
  color: allBgClr,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: Colors.grey.shade300),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 0,
      blurRadius: 0,
      offset: const Offset(0, 1), // changes position of shadow
    ),
  ],
);
