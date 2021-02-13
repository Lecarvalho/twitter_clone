import 'package:flutter/material.dart';
import 'package:twitter_clone/view/widgets/following_followers_count_widget.dart';
import 'package:twitter_clone/view/widgets/profile_picture_name_vertical_widget.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureNameVerticalWidget(
            photoUrl: "assets/profile-pictures/at.jpg",
            profileName: "Leandro Carvalho",
            profileNickName: "@dev_lecarvalho",
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
            child: Image.asset("assets/logos/flutter-twitter-clone.png"),
          )
        ],
      ),
    );
  }
}
