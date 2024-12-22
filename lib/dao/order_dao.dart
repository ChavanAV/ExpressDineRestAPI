import 'dart:convert';

import 'package:express_dine_rest_api/models/order_model.dart';
import 'package:express_dine_rest_api/network/endpoints.dart';
import 'package:http/http.dart' as http;

class OrderDao {
  Future<List<Order>> getHotelOrders(int hid) async {
    try {
      final url = Uri.parse('${API.getHotelOrders}/$hid');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final List<dynamic> resData = resBody['data'];
        return resData.map((order) => Order.fromJson(order)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Order>> getUSerOrders(int uid) async {
    try {
      final url = Uri.parse('${API.getUserOrders}/$uid');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final List<dynamic> resData = resBody['data'];
        return resData.map((order) => Order.fromJson(order)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
