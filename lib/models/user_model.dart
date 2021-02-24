import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model_base.dart';

class UserModel extends ModelBase {
  UserModel({
    @required this.avatar,
    @required this.name,
    @required this.nickname,
    this.id,
    this.bio,
    this.emailAddress,
    this.inscriptionDate,
  });
  
  String id;
  String avatar;
  String name;
  String nickname;
  String bio;
  String emailAddress;
  DateTime inscriptionDate;

  String get inscriptionDateMonthYear => DateFormat.MMMM().add_y().format(inscriptionDate);

  factory UserModel.fromMapSingleTweet(Map<String, dynamic> data){
    return UserModel(
      id: data["id"],
      avatar: data["avatar"],
      name: data["name"],
      nickname: data["nickname"]
    );
  }

  factory UserModel.fromMapProfile(Map<String, dynamic> data){
    return UserModel(
      id: data["id"],
      avatar: data["avatar"],
      name: data["name"],
      nickname: data["nickname"],
      bio: data["bio"],
      emailAddress: data["emailAddress"],
      inscriptionDate: DateTime.parse(data["inscriptionDate"]),
    );
  }
}