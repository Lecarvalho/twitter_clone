import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    @required this.photoUrl,
    @required this.name,
    @required this.nickname,
    this.bio,
    this.emailAdress,
    this.inscriptionDate,
  });
  
  String photoUrl;
  String name;
  String nickname;
  String bio;
  String emailAdress;
  DateTime inscriptionDate;

  String get inscriptionDateMonthYear => DateFormat.MMMM().add_y().format(inscriptionDate);
}