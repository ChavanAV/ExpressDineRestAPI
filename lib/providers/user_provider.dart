import 'package:express_dine_rest_api/dao/user_dao.dart';
import 'package:express_dine_rest_api/models/user_model.dart';
import 'package:express_dine_rest_api/views/auth/loginPage.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  final UserDao _userDao = UserDao();

  User? get user => _user;

  Future<bool> fetchUserDetails(username, pin) async {
    try {
      _user = await _userDao.getUserByNameAndPassword(username, pin);
      notifyListeners();
      if (_user != null) return true;
      return false;
    } catch (error) {
      return false;
    }
  }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }
}
