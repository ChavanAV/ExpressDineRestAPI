import 'package:flutter/material.dart';

import '../widgets/decoration.dart';

class DataInputCard extends StatelessWidget {
  final String name;
  final String? helperText;
  final TextInputType? keyBoardType;
  final TextEditingController controller;
  final double? height;
  const DataInputCard(
      {Key? key,
      required this.name,
      required this.controller,
      this.keyBoardType,
      this.helperText,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, color: Color(0xFF474E68)),
        ),
        SizedBox(
          height: height,
          child: TextFormField(
            controller: controller,
            keyboardType: keyBoardType,
            cursorColor: orangeBtnClr,
            cursorHeight: 23,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 2),
              helperText: helperText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }
}
