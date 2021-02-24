import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/home_page.dart';
import 'package:twitter_clone/views/pages/login_page.dart';
import 'package:twitter_clone/views/pages/profile_page.dart';
import 'package:twitter_clone/views/pages/search_page.dart';

class Routes {
  
  static const String home = "/home";
  static const String search = "/search";
  static const String profile = "/profile";
  static const String login = "/login";

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    search: (BuildContext context) => SearchPage(),
    profile: (BuildContext context) => ProfilePage(),
    login: (BuildContext context) => LoginPage(),
  };
}