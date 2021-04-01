import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';

import 'assets.dart';

class ProjectIcons {
  static const double _microIconSize = 16;
  static const double _smallIconSize = 18;
  static const double _bigIconSize = 23;

  static Image get reply => Image.asset(
        AssetsIcons.reply,
        width: _microIconSize,
        height: _microIconSize,
      );

  static Image get retweet => Image.asset(
        AssetsIcons.retweet,
        width: _smallIconSize,
        height: _smallIconSize,
      );

  static Image get retweetColored => Image.asset(
        AssetsIcons.retweetColored,
        width: _smallIconSize,
        height: _smallIconSize,
      );

  static Image get like => Image.asset(
        AssetsIcons.like,
        width: _microIconSize,
        height: _microIconSize,
      );

  static Image get likeSolid => Image.asset(
        AssetsIcons.likeSolid,
        width: _microIconSize,
        height: _microIconSize,
      );

  static Image get likeSolidDarken => Image.asset(
        AssetsIcons.likeSolidDarken,
        width: _microIconSize,
        height: _microIconSize,
      );

  static Image get homeSolid => Image.asset(
        AssetsIcons.homeSolid,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get home => Image.asset(
        AssetsIcons.home,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get searchSolid => Image.asset(
        AssetsIcons.searchSolid,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get search => Image.asset(
        AssetsIcons.search,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get notificationSolid => Image.asset(
        AssetsIcons.notificationSolid,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get notification => Image.asset(
        AssetsIcons.notification,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get profileSolid => Image.asset(
        AssetsIcons.profileSolid,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get profile => Image.asset(
        AssetsIcons.profile,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get feature => Image.asset(
        AssetsIcons.feature,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get addTweet => Image.asset(
        AssetsIcons.addTweet,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get starSolid => Image.asset(
        AssetsIcons.starSolid,
        width: _bigIconSize,
        height: _bigIconSize,
      );

  static Image get appIcon => Image.asset(
        AssetsIcons.appIcon,
        width: 80,
        height: 80,
      );

  static Image get googleIcon => Image.asset(
        AssetsIcons.google,
        width: 40,
        height: 40,
      );

  static Icon get photoIcon => Icon(
        Icons.photo_camera_outlined,
        color: ProjectColors.black,
      );

  static Icon get isNotConfirmedYet => Icon(
      Icons.check
  );

  static Icon get isConfirmedSolid => Icon(
    Icons.check,
    color: ProjectColors.blueActive,
  );

  static Icon get notConfirmedSolid => Icon(
    Icons.error,
    color: ProjectColors.red,
  );
}
