// class Order {
//   String oid;
//   String userName;
//   String itemName;
//   String itemPrice;
//   String quantity;
//   String totalPrice;
//   String deliveryTime;
//   String trainName;
//   String compartment;
//   String seatNo;
//   String contactNo;
//   String date;
//   String hid;
//   String uid;
//   Order(
//     this.oid,
//     this.userName,
//     this.itemName,
//     this.itemPrice,
//     this.quantity,
//     this.totalPrice,
//     this.deliveryTime,
//     this.trainName,
//     this.compartment,
//     this.seatNo,
//     this.contactNo,
//     this.date,
//     this.hid,
//     this.uid,
//   );
//   Map<String, dynamic> toJson() => {
//         'userName': userName,
//         'itemName': itemName,
//         'itemPrice': itemPrice,
//         'quantity': quantity,
//         'totalPrice': totalPrice,
//         'deliveryTime': deliveryTime,
//         'trainName': trainName,
//         'compartment': compartment,
//         'seatNo': seatNo,
//         'contactNo': contactNo,
//         'date': date,
//         'hid': hid,
//         'uid': uid,
//       };
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         json['oid'],
//         json['userName'],
//         json['itemName'],
//         json['itemPrice'],
//         json['quantity'],
//         json['totalPrice'],
//         json['deliveryTime'],
//         json['trainName'],
//         json['compartment'],
//         json['seatNo'],
//         json['contactNo'],
//         json['date'],
//         json['hid'],
//         json['uid'],
//       );
// }

import 'menu_model.dart';
import 'user_model.dart';

class Order {
  final int? oid;
  final User? user;
  final int quantity;
  final double totalPrice;
  final String trainName;
  final String compartment;
  final String seatNo;
  final int contactNo;
  final DateTime date;
  final Menu? menu;

  Order({
    this.oid,
    this.user,
    required this.quantity,
    required this.totalPrice,
    required this.trainName,
    required this.compartment,
    required this.seatNo,
    required this.contactNo,
    required this.date,
    this.menu,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      oid: json['oid'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      trainName: json['trainName'],
      compartment: json['compartment'],
      seatNo: json['seatNo'],
      contactNo: json['contactNo'],
      date: DateTime.parse(json['date']),
      menu: json['menu'] != null ? Menu.fromJson(json['menu']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'quantity': quantity,
      'totalPrice': totalPrice,
      'trainName': trainName,
      'compartment': compartment,
      'seatNo': seatNo,
      'contactNo': contactNo,
      'date': date.toIso8601String()
    };
    if (oid != null) {
      data['oid'] = oid;
    }
    if (user != null) {
      data['user'] = user?.toJson();
    }
    if (menu != null) {
      data['menu'] = menu?.toJson();
    }
    return data;
  }
}
