import 'dart:convert';

import 'package:express_dine_rest_api/models/user_model.dart';
import 'package:express_dine_rest_api/network/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserDao {
  Future<Response?> saveUser(User user) async {
    final url = Uri.parse(API.signUp);
    try {
      return await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );
      // final response = await http.post(
      //   url,
      //   headers: {"Content-Type": "application/json"},
      //   body: jsonEncode(user.toJson()),
      // );

      // print(response.body);
      // if (response.statusCode == 201) {
      //   // final Map<String, dynamic> body = jsonDecode(response.body);
      //   // return User.fromJson(body['data']);
      //   return response;
      // } else {
      //   print("From api service - Failed to save user: ${response.statusCode}");
      // }
    } catch (e) {
      print("From api service - Error: $e");
    }
    return null;
  }

  Future<User?> getUserByNameAndPassword(
      String userName, String password) async {
    final url = Uri.parse('${API.loginUser}/$userName/$password');
    try {
      print('started');
      final response = await http.get(url);
      print('ended');
      if (response.statusCode == 200) {
        final Map<String, dynamic> resBody = jsonDecode(response.body);
        print('resBody[data] :  ${resBody['data']}');
        return User.fromJson(resBody['data']);
      } else {
        print("Failed to get user: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
