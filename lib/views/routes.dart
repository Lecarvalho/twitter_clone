import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/preload_page.dart';
import 'package:twitter_clone/views/pages/reply_page.dart';

import 'pages/opened_tweet_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/create_user_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/new_tweet_page.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart';

class Routes {
  
  static const String home = "/home";
  static const String search = "/search";
  static const String profile = "/profile";
  static const String login = "/login";
  static const String new_tweet = "/new_tweet";
  static const String opened_tweet = "/opened_tweet";
  static const String reply = "/reply";
  static const String create_user = "/create_user";
  static const String edit_profile = "/edit_profile";
  static const String preload = "/preload";

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    search: (BuildContext context) => SearchPage(),
    profile: (BuildContext context) => ProfilePage(),
    login: (BuildContext context) => LoginPage(),
    new_tweet: (BuildContext context) => NewTweetPage(),
    opened_tweet: (BuildContext context) => OpenedTweetPage(),
    reply: (BuildContext context) => ReplyPage(),
    create_user: (BuildContext context) => CreateUserPage(),
    edit_profile: (BuildContext context) => EditProfilePage(),
    preload: (BuildContext context) => PreloadPage(),
  };
}