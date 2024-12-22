import 'package:flutter/material.dart';

import '../views/user/user_home_screen.dart';
import 'decoration.dart';

class Utils {
  // SplashServices splashServices = SplashServices();

  void showSnacBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        showCloseIcon: true,
        backgroundColor: orangeBtnClr,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        content: Text(content)));
  }

  void dialog(BuildContext context, int uid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.orange.shade200,
          title: const Text("Your order has been placed"),
          content: CircleAvatar(
            radius: 60,
            backgroundColor: allBgClr,
            child: const Icon(Icons.check, size: 70, color: Colors.green),
          ),
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserHomeScreen(uid: uid)),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Back to home",
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
          ],
        );
      },
    );
  }
}
