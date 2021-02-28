import 'package:flutter/material.dart';

import 'assets.dart';

class ProjectIcons {
  static const double _microIconSize = 16;
  static const double _smallIconSize = 18;
  static const double _bigIconSize = 23;

  static final Image comment = Image.asset(
    AssetsIcons.comment,
    width: _microIconSize,
    height: _microIconSize,
  );

  static final Image retweet = Image.asset(
    AssetsIcons.retweet,
    width: _smallIconSize,
    height: _smallIconSize,
  );

  static final Image heart = Image.asset(
    AssetsIcons.heart,
    width: _microIconSize,
    height: _microIconSize,
  );

  static final Image homeSolid = Image.asset(
    AssetsIcons.homeSolid,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image home = Image.asset(
    AssetsIcons.home,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image searchSolid = Image.asset(
    AssetsIcons.searchSolid,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image search = Image.asset(
    AssetsIcons.search,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image notificationSolid = Image.asset(
    AssetsIcons.notificationSolid,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image notification = Image.asset(
    AssetsIcons.notification,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image profileSolid = Image.asset(
    AssetsIcons.profileSolid,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image profile = Image.asset(
    AssetsIcons.profile,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image feature = Image.asset(
    AssetsIcons.feature,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image addTweet = Image.asset(
    AssetsIcons.addTweet,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image starSolid = Image.asset(
    AssetsIcons.starSolid,
    width: _bigIconSize,
    height: _bigIconSize,
  );

  static final Image appIcon = Image.asset(
    AssetsIcons.appIcon,
    width: 80,
    height: 80,
  );

  static final Image googleIcon = Image.asset(
    AssetsIcons.google,
    width: 40,
    height: 40,
  );

  static final Icon photoIcon = Icon(Icons.photo_camera_outlined);
}
