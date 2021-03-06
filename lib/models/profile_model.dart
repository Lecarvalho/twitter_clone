import 'package:intl/intl.dart';

import 'user_model.dart';

class ProfileModel extends UserModel {
  ProfileModel({
    required String name,
    String? email,
    required String nickname,
  }) : super(
          name: name,
          email: email,
          nickname: nickname,
        );

  late String id;
  late String avatar;
  late String bio;
  late DateTime inscriptionDate;
  late List<String> following;
  late int followersCount;

  int get followingCount => following.length;

  String get inscriptionDateMonthYear =>
      DateFormat.MMMM().add_y().format(inscriptionDate);

  factory ProfileModel.fromMapSingleTweet(Map<String, dynamic> data) {
    var profile = ProfileModel(
      name: data["name"],
      nickname: data["nickname"],
    );

    profile.avatar = data["avatar"];
    profile.id = data["id"];

    return profile;
  }

  factory ProfileModel.fromMapGetProfile(Map<String, dynamic> data) {
    var profile = ProfileModel(
      name: data["name"],
      nickname: data["nickname"],
    );

    profile.id = data["id"];
    profile.avatar = data["avatar"];
    profile.bio = data["bio"];
    profile.inscriptionDate = DateTime.parse(data["inscriptionDate"]);
    profile.followersCount = data["followersCount"] ?? 0;
    profile.following =
        data["following"] != null ? List.from(data["following"]) : List.empty();

    return profile;
  }

  // factory ProfileModel.toCreateProfile({
  //   required String name,
  //   required String nickname,
  //   required String bio,
  //   required String avatar,
  //   required DateTime inscriptionDate,
  // }) {
  //   var profile = ProfileModel(
  //     name: name,
  //     nickname: nickname,
  //   );

  //   profile.bio = bio;
  //   profile.avatar = avatar;
  //   profile.inscriptionDate = inscriptionDate;

  //   return profile;
  // }

  // factory ProfileModel.toCreateProfile({
  //   String name,
  //   String nickname,
  //   String bio,
  //   String avatar,
  // }) {
  //   return ProfileModel(
  //     name: name,
  //     nickname: nickname,
  //     bio: bio,
  //     avatar: avatar,
  //   );
  // }
}
