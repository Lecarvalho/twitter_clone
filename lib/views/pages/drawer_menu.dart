import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/views/widgets/following_followers_count_widget.dart';
import 'package:twitter_clone/views/widgets/profile_picture_name_nick_vertical_widget.dart';

import '../resources/assets.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureNameNickVerticalWidget(
            profileModel: ProfileModel(
              photoUrl: "assets/profile-pictures/at.jpg",
              profileName: "Leandro Carvalho",
              profileNickName: "@dev_lecarvalho",
            ),
          ),
          SizedBox(height: 7),
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
    );
  }
}
