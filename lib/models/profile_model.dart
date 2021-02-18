import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileModel {
  ProfileModel({
    @required this.photoUrl,
    @required this.profileName,
    @required this.profileNickname,
    this.bio,
    this.emailAdress,
    this.inscriptionDate,
  });
  
  String photoUrl;
  String profileName;
  String profileNickname;
  String bio;
  String emailAdress;
  DateTime inscriptionDate;

  String get inscriptionDateMonthYear => DateFormat.MMMM().add_y().format(inscriptionDate);
}