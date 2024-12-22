import 'dart:convert';

import 'package:express_dine_rest_api/dto/hotel_dto.dart';
import 'package:express_dine_rest_api/models/hotel_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../network/endpoints.dart';

class HotelDao {
  Future<Response?> registerHotelWithUser(Hotel hotel) async {
    final url = Uri.parse(API.registerHotelWithUser);
    try {
      return await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(hotel.toJson()),
      );
    } catch (e) {
      print("From api service - Error: $e");
    }
    return null;
  }

  Future<HotelDto?> getHotelDetails(int uid) async {
    final url = Uri.parse('${API.getHotelDetails}/$uid');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> resBody = jsonDecode(response.body);
        print(resBody['data']);
        return HotelDto.fromJson(resBody['data']);
      } else {
        print("Failed to fetch hotel: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<bool> openCloseHotel(bool isOpen, int hid) async {
    final url = Uri.parse('${API.updateIsOpen}/$isOpen/$hid');
    try {
      final response = await http.put(url);
      print('response =  ${response.body}');
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        return resBody['data'];
      } else {
        print("Failed : ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<List<HotelDto>?> getAllHotelInfo() async {
    final url = Uri.parse(API.getAllHotels);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> resBody = jsonDecode(response.body);
        print(resBody['data']);
        final List<dynamic> hotels = resBody['data'];
        return hotels.map((hotel) => HotelDto.fromJson(hotel)).toList();
      } else {
        print("Failed to fetch hotels: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
