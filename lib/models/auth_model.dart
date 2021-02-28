import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/model_base.dart';

class AuthModel extends ModelBase {
  String userId;
  String avatar;
  String email;
  String password;
  List<String> following;
  AuthModel({
    @required this.userId,
    this.avatar,
    this.following,
  });
  factory AuthModel.fromMap(Map<String, dynamic> data) {
    return AuthModel(
      userId: data["id"],
      avatar: data["avatar"],
      following: List<String>.from(data["following"]),
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
