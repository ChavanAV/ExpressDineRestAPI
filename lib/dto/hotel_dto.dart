class HotelDto {
  int hid;
  String hotelName;
  String hotelAdd;
  String stationName;
  bool isOpen;

  HotelDto({
    required this.hid,
    required this.hotelName,
    required this.hotelAdd,
    required this.stationName,
    required this.isOpen,
  });

  // Factory constructor to create a HotelDto from JSON
  factory HotelDto.fromJson(Map<String, dynamic> json) {
    return HotelDto(
      hid: json['hid'],
      hotelName: json['hotelName'],
      hotelAdd: json['hotelAdd'],
      stationName: json['stationName'],
      isOpen: json['isOpen'],
    );
  }

  // Method to convert HotelDto to JSON
  Map<String, dynamic> toJson() {
    return {
      'hid': hid,
      'hotelName': hotelName,
      'hotelAdd': hotelAdd,
      'stationName': stationName,
      'isOpen': isOpen,
    };
  }
}

class MenuDto {
  int menuId;
  String itemName;
  double price;

  MenuDto({
    required this.menuId,
    required this.itemName,
    required this.price,
  });

  // Factory constructor to create a MenuDto from JSON
  factory MenuDto.fromJson(Map<String, dynamic> json) {
    return MenuDto(
      menuId: json['menuId'],
      itemName: json['itemName'],
      price: json['price'],
    );
  }

  // Method to convert MenuDto to JSON
  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'itemName': itemName,
      'price': price,
    };
  }
}
