import 'package:express_dine_rest_api/models/user_model.dart';

class Hotel {
  int? hid;
  User user;
  String hotelName;
  String hotelAdd;
  String stationName;
  bool isOpen;

  Hotel({
    this.hid,
    required this.user,
    required this.hotelName,
    required this.hotelAdd,
    required this.stationName,
    required this.isOpen,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user': user,
      'hotelName': hotelName,
      'hotelAdd': hotelAdd,
      'stationName': stationName,
      'isOpen': isOpen,
    };
    if (hid != null) {
      data['hid'] = hid;
    }
    return data;
  }

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hid: json['hid']! as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      hotelName: json['hotelName'] as String,
      hotelAdd: json['hotelAdd'] as String,
      stationName: json['stationName'] as String,
      isOpen: json['isOpen'] as bool,
    );
  }
}
//
// class GetHotel {
//   String hid;
//   String hotelName;
//   String stationName;
//   String address;
//   String isOpen;
//   GetHotel(
//       this.hid, this.isOpen, this.hotelName, this.stationName, this.address);
//   factory GetHotel.fromJson(Map<String, dynamic> json) => GetHotel(
//         json['hid'],
//         json['is_open'],
//         json['hotel_name'],
//         json['station_name'],
//         json['hotel_add'],
//       );
// }
