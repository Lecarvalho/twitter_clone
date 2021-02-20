import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/views/widgets/tweet/following_followers_count_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_name_nick_vertical_widget.dart';

import '../resources/assets.dart';

class DrawerMenu extends Drawer {
  DrawerMenu()
      : super(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePictureNameNickVerticalWidget(
                  profileModel: UserModel(
                    photoUrl: "assets/profile-pictures/at.jpg",
                    name: "Leandro Carvalho",
                    nickname: "@dev_lecarvalho",
                  ),
                ),
                SizedBox(height: 10),
                FollowingFollowersCountWidget(
                  totalFollowers: 216,
                  totalFollowing: 117,
                ),
                SizedBox(height: 25),
                Text("Logoff"),
                SizedBox(height: 50),
                Center(
                  child: Image.asset(AssetsLogos.flutterTwitterClone),
                )
              ],
            ),
          ),
        );
}
