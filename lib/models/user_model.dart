// class User {
//   int? id;
//   String userName;
//   String password;
//
//   User({this.id, required this.userName, required this.password});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       userName: json['user_name'],
//       password: json['password'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_name': userName,
//       'password': password,
//     };
//   }
// }
//

class User {
  int? uid;
  String userName;
  String password;
  String role;
  User({
    this.uid,
    required this.userName,
    required this.password,
    required this.role,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userName': userName,
      'password': password,
      'role': role,
    };
    if (uid != null) {
      data['uid'] = uid;
    }
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid']! as int,
      userName: json['userName'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }
}

// class FetchUser {
//   String userName;
//   String pin;
//   String role;
//   String uid;
//   FetchUser(
//     this.userName,
//     this.pin,
//     this.role,
//     this.uid,
//   );
//
//   Map<String, dynamic> toJson() => {
//         'name': userName,
//         'pin': pin,
//       };
//
//   factory FetchUser.fromJson(Map<String, dynamic> json) {
//     return FetchUser(
//       json['name'],
//       json['pin'],
//       json['role'],
//       json['uid'],
//     );
//   }
// }
