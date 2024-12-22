import 'package:flutter/material.dart';

import '../widgets/decoration.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double padding;
  const MyCard(
      {Key? key, required this.child, this.color, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      color: (color == null) ? cardBgClr : color,
      surfaceTintColor: cardBgClr,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
