import 'package:express_dine_rest_api/views/auth/loginPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2));
    super.initState();
    nav();
  }

  void nav() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(children: [
        SizedBox(
          height: size.height * 0.2,
        ),
        // Image.asset("assets/images/logo.jpg"),
        SizedBox(
          height: size.height * 0.1,
        ),
        const Center(
          child: Text(
            "Eat With Test !",
            // style: stationTextStyle,
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
      ])),
    );
  }
}
