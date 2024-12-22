import 'dart:convert';

import 'package:express_dine_rest_api/models/menu_model.dart';
import 'package:express_dine_rest_api/network/endpoints.dart';
import 'package:http/http.dart' as http;

class MenuDao {
  Future<bool> addMenu(Menu menu, int hid) async {
    final url = Uri.parse('${API.saveMenu}/$hid');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(menu.toJson()),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print("Failed to save menu: ${response.body}");
        return false;
      }
    } catch (e) {
      print("From api service - Error: $e");
      return false;
    }
  }

  Future<List<Menu>?> fetchMenus(int hid) async {
    try {
      final response = await http.get(Uri.parse('${API.allMenu}/$hid'));
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        List<dynamic> data = resBody['data'];
        return data.map((menu) => Menu.fromJson(menu)).toList();
      } else {
        print("Something went wrong");
        return null;
      }
    } catch (e) {
      print("From api service - Error: $e");
      throw Exception('Failed to load menus');
    }
    return null;
  }

  Future<bool?> updateMenus(Menu menu) async {
    try {
      final url = Uri.parse(API.updateMenu);
      final res = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(menu.toJson()),
      );
      if (res.statusCode == 200) {
        final resBody = jsonDecode(res.body);
        final data = resBody['data'];
        if (data) return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      // throw Exception('Failed to load menus');
    }
    return false;
  }

  Future<bool?> deleteMenus(int mid) async {
    try {
      final url = Uri.parse('${API.deleteMenu}/$mid');
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        var resData = resBody['data'];
        if (resData) return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      // throw Exception('Failed to load menus');
    }
    return false;
  }
}
