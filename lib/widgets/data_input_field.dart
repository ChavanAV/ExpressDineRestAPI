import 'package:flutter/material.dart';

import '../widgets/decoration.dart';

class DataInput extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  const DataInput(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.hintText,
      required this.obscureText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        labelText: labelText,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        labelStyle: const TextStyle(color: Colors.black),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return labelText;
        } else {
          return null;
        }
      },
      cursorHeight: 25,
      obscureText: obscureText,
      cursorColor: orangeBtnClr,
    );
  }
}
