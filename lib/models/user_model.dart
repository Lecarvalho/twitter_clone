import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
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
}