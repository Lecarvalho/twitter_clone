import 'package:intl/intl.dart';

import 'user_model.dart';

class ProfileModel extends UserModel {
  ProfileModel({
    required this.id,
    required String name,
    required this.avatar,
    required String nickname,
  }) : super(
          name: name,
          id: id,
          nickname: nickname,
        );

  String id;
  String avatar;
  
  late String bio;
  late DateTime inscriptionDate;
  late List<String> following;
  late int followersCount;

  int get followingCount => following.length;

  String get inscriptionDateMonthYear =>
      DateFormat.MMMM().add_y().format(inscriptionDate);

  factory ProfileModel.fromMapSingleTweet(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      name: data["name"],
      avatar: data["avatar"],
      nickname: data["nickname"],
    );
  }

  factory ProfileModel.fromMapGetProfile(Map<String, dynamic> data) {
    var profile = ProfileModel(
      id: data["id"],
      name: data["name"],
      avatar: data["avatar"],
      nickname: data["nickname"],
    );

    profile.bio = data["bio"];
    profile.inscriptionDate = DateTime.parse(data["inscriptionDate"]);
    profile.followersCount = data["followersCount"] ?? 0;
    profile.following =
        data["following"] != null ? List.from(data["following"]) : List.empty();

    return profile;
  }
}
