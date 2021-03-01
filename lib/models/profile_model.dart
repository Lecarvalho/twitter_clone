import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model_base.dart';

class ProfileModel extends ModelBase {
  ProfileModel({
    @required this.avatar,
    @required this.name,
    @required this.nickname,
    this.id,
    this.bio,
    this.inscriptionDate,
  });

  String id;
  String avatar;
  String name;
  String nickname;
  String bio;
  DateTime inscriptionDate;

  String get inscriptionDateMonthYear =>
      DateFormat.MMMM().add_y().format(inscriptionDate);

  factory ProfileModel.fromMapSingleTweet(Map<String, dynamic> data) {
    return ProfileModel(
        id: data["id"],
        avatar: data["avatar"],
        name: data["name"],
        nickname: data["nickname"]);
  }

  factory ProfileModel.fromMapProfile(Map<String, dynamic> data) {
    return ProfileModel(
      id: data["id"],
      avatar: data["avatar"],
      name: data["name"],
      nickname: data["nickname"],
      bio: data["bio"],
      inscriptionDate: DateTime.parse(data["inscriptionDate"]),
    );
  }

  factory ProfileModel.toMap({
    String name,
    String nickname,
  }) {
    return ProfileModel(
      name: name,
      nickname: nickname,
      avatar: null,
    );
  }
}
