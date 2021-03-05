import 'package:flutter/foundation.dart';

import 'model_base.dart';

class UserModel extends ModelBase {
  String id;
  String name;
  String email;
  String nickname;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.nickname,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data["id"],
      name: data["name"],
      email: data["email"],
      nickname: data["nickname"],
    );
  }

  static bool isValidEmailPassword(String email, String password) {
    var isValidPwd = password.isNotEmpty && password.length > 3;

    return _isValidEmail(email) && isValidPwd;
  }

  static bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
