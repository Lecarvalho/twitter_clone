import 'package:intl/intl.dart';

import 'user_model.dart';

class ProfileModel extends UserModel {
  ProfileModel({
    this.avatar,
    this.bio,
    this.inscriptionDate,
    this.followersCount,
    this.following,
    String id,
    String name,
    String email,
    String nickname,
  }) : super(
    id: id,
    name: name,
    email: email,
    nickname: nickname,
  );

  String avatar;
  String bio;
  DateTime inscriptionDate;
  List<String> following;
  int get followingCount => following.length;
  int followersCount;

  String get inscriptionDateMonthYear =>
      DateFormat.MMMM().add_y().format(inscriptionDate);

  factory ProfileModel.fromMapSingleTweet(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      avatar: data["avatar"],
      name: data["name"],
      nickname: data["nickname"],
    );
  }

  factory ProfileModel.fromMapGetProfile(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      avatar: data["avatar"],
      name: data["name"],
      nickname: data["nickname"],
      bio: data["bio"],
      inscriptionDate: DateTime.parse(data["inscriptionDate"]),
      followersCount: data["followersCount"] ?? 0,
      following:
          data["following"] != null ? List.from(data["following"]) : List(),
    );
  }

  factory ProfileModel.toCreateProfile({
    String name,
    String nickname,
    String bio,
    String avatar,
  }) {
    return ProfileModel(
      name: name,
      nickname: nickname,
      bio: bio,
      avatar: avatar,
    );
  }
}
