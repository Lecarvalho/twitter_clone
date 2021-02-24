import 'package:flutter/foundation.dart';
import 'package:twitter_clone/models/model_base.dart';

class AuthModel extends ModelBase {
  String userId;
  List<String> following;
  AuthModel({
    @required this.userId,
    this.following,
  });
  factory AuthModel.fromMap(Map<String, dynamic> data) {
    return AuthModel(
      userId: data["id"],
      following: List<String>.from(data["following"]),
    );
  }
}
