import 'package:flutter/material.dart';
import 'package:twitter_clone/views/pages/big_tweet_page.dart';
import 'package:twitter_clone/views/pages/create_user_page.dart';
import 'package:twitter_clone/views/pages/create_edit_profile_page.dart';
import 'package:twitter_clone/views/pages/home_page.dart';
import 'package:twitter_clone/views/pages/login_page.dart';
import 'package:twitter_clone/views/pages/new_tweet_page.dart';
import 'package:twitter_clone/views/pages/profile_page.dart';
import 'package:twitter_clone/views/pages/reply_page.dart';
import 'package:twitter_clone/views/pages/search_page.dart';

class Routes {
  
  static const String home = "/home";
  static const String search = "/search";
  static const String profile = "/profile";
  static const String login = "/login";
  static const String new_tweet = "/new_tweet";
  static const String big_tweet = "/big_tweet";
  static const String reply = "/reply";
  static const String create_user = "/create_user";
  static const String create_edit_profile = "/create_edit_profile";

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomePage(),
    search: (BuildContext context) => SearchPage(),
    profile: (BuildContext context) => ProfilePage(),
    login: (BuildContext context) => LoginPage(),
    new_tweet: (BuildContext context) => NewTweetPage(),
    big_tweet: (BuildContext context) => BigTweetPage(),
    reply: (BuildContext context) => ReplyPage(),
    create_user: (BuildContext context) => CreateUserPage(),
    create_edit_profile: (BuildContext context) => CreateEditProfilePage(),
  };
}