// class Menu {
//   String dishName;
//   String price;
//   String duration;
//   String description;
//   String isSpecial;
//   String isAvail;
//   String imageData;
//   int uid;
//   Menu(
//     this.dishName,
//     this.price,
//     this.duration,
//     this.description,
//     this.isSpecial,
//     this.isAvail,
//     this.imageData,
//     this.uid,
//   );
//
//   Map<String, dynamic> toJson() => {
//         'dishName': dishName,
//         'price': price,
//         'duration': duration,
//         'description': description,
//         'isSpecial': isSpecial,
//         'isAvail': isAvail,
//         'image_data': imageData,
//         'uid': uid,
//       };
// }
//
// class GetMenus {
//   String mid;
//   String dishName;
//   String price;
//   String duration;
//   String description;
//   String isSpecial;
//   String isAvail;
//   String hid;
//   GetMenus(
//     this.mid,
//     this.dishName,
//     this.price,
//     this.duration,
//     this.description,
//     this.isSpecial,
//     this.isAvail,
//     this.hid,
//   );
//   // Map<String, dynamic> toJson() => {
//   //       'uid': uid,
//   //     };
//   factory GetMenus.fromJson(Map<String, dynamic> json) => GetMenus(
//         json['mid'],
//         json['dish_name'],
//         json['price'],
//         json['duration'],
//         json['description'],
//         json['is_special'],
//         json['is_avail'],
//         json['hid'],
//       );
// }

class Menu {
  late int? mid;
  late String dishName;
  late double price;
  late int duration;
  late String description;
  late bool isSpecial;
  late bool isAvail;
  late String? image;

  Menu({
    this.mid,
    required this.dishName,
    required this.price,
    required this.duration,
    required this.description,
    required this.isSpecial,
    required this.isAvail,
    this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      mid: json['mid'],
      dishName: json['dishName'],
      price: json['price'],
      duration: json['duration'],
      description: json['description'],
      isSpecial: json['isSpecial'],
      isAvail: json['isAvail'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'dishName': dishName,
      'price': price,
      'duration': duration,
      'description': description,
      'isSpecial': isSpecial,
      'isAvail': isAvail,
    };
    if (mid != null) {
      data['mid'] = mid;
    }
    if (image != null) {
      data['image'] = image;
    }

    return data;
  }
}

// class Hotel {
//   // Define the Hotel class as per your existing Java entity
//   // Example fields; adjust these to match your actual `Hotel` entity.
//   late int hid;
//   late String hotelName;
//
//   Hotel({
//     required this.hid,
//     required this.hotelName,
//   });
//
//   // Factory constructor for JSON deserialization
//   factory Hotel.fromJson(Map<String, dynamic> json) {
//     return Hotel(
//       hid: json['hid'],
//       hotelName: json['hotelName'],
//     );
//   }
//
//   // Method for JSON serialization
//   Map<String, dynamic> toJson() {
//     return {
//       'hid': hid,
//       'hotelName': hotelName,
//     };
//   }
// }
