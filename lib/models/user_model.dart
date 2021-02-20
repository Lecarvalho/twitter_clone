import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    @required this.avatar,
    @required this.name,
    @required this.nickname,
    this.bio,
    this.emailAddress,
    this.inscriptionDate,
  });
  
  String avatar;
  String name;
  String nickname;
  String bio;
  String emailAddress;
  DateTime inscriptionDate;

  String get inscriptionDateMonthYear => DateFormat.MMMM().add_y().format(inscriptionDate);
}