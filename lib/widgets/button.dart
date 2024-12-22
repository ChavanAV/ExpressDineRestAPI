import 'package:flutter/material.dart';

import '../widgets/decoration.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget btnName;
  void Function() press;
  MyElevatedButton({Key? key, required this.btnName, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: regularStyle,
            backgroundColor: MaterialStatePropertyAll(orangeBtnClr)),
        onPressed: press,
        child: btnName);
  }
}
