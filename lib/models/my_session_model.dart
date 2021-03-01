import 'package:twitter_clone/models/model_base.dart';

import 'profile_model.dart';

class MySessionModel extends ModelBase {
  String profileId;
  String email;
  String password;
  List<String> following;
  ProfileModel myProfile;
  int followingCount;
  int followersCount;

  MySessionModel({
    this.profileId,
    this.myProfile,
    this.email,
    this.following,
    this.followingCount,
    this.followersCount,
  });
  factory MySessionModel.fromMap(Map<String, dynamic> data) {
    return MySessionModel(
      profileId: data["id"],
      following: List<String>.from(data["following"]),
      followingCount: data["followingCount"],
      followersCount: data["followersCount"],
    );
  }

  static bool isValidEmailPassword(String email, String password) {
    var isValidPwd = password.isNotEmpty && password.length > 3;

    return _isValidEmail(email) && isValidPwd;
  }

  static bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  factory MySessionModel.toMap({
    String name,
    String email,
    String nickname,
    int followingCount,
    int followersCount,
  }) {
    return MySessionModel(
      myProfile: ProfileModel.toMap(
        name: name,
        nickname: nickname,
      ),
      email: email,
      followingCount: followingCount,
      followersCount: followersCount,
    );
  }
}
