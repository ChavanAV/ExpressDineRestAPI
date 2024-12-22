import 'package:express_dine_rest_api/providers/user_provider.dart';
import 'package:express_dine_rest_api/views/auth/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../widgets/data_input_field.dart';
import '../../widgets/decoration.dart';
import '../admin/admin_home_screen.dart';
import '../user/user_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;
  bool obscure = false;
  bool userAvail = false;

  Future<bool> findUser(String userName, String password) async {
    // String s = '';
    setState(() {
      isLogin = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userAvail = await userProvider.fetchUserDetails(userName, password);
    setState(() {
      isLogin = false;
    });
    return userAvail;
  }

  navToUser(uid) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomeScreen(uid: uid),
        ));
  }

  navToAdmin(user) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHomeScreen(user: user),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(
        builder: (context, userProvider, child) => Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: btnTextFieldPadding,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DataInput(
                              labelText: "Enter username",
                              controller: emailController,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            DataInput(
                                labelText: "Enter password",
                                controller: passwordController,
                                obscureText: !obscure),
                            SizedBox(
                              height: size.height * 0.001,
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: const Text("Show password"))
                          ],
                        ),
                      )),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Container(
                    height: 45,
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyElevatedButton(
                        btnName: !isLogin
                            ? Text(
                                "Login",
                                style: myElevatedButtonInnerTextStyle,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white),
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isAvail = await findUser(
                              emailController.text,
                              passwordController.text,
                            );
                            if (!isAvail) {
                              Fluttertoast.showToast(
                                  msg: "User not found try again!!!");
                            } else if (userProvider.user!.role == 'No') {
                              navToUser(userProvider.user!.uid);
                            } else if (userProvider.user!.role == 'Yes') {
                              navToAdmin(userProvider.user);
                            }
                          }
                        }),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text("SignUp")),
                    ],
                  ),
                ]),
              ),
            ));
  }
}
