import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/model_base.dart';

class AuthModel extends ModelBase {
  String userId;
  String avatar;
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
}
