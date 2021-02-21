import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/widgets/tweet/following_followers_count_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_name_nick_vertical_widget.dart';
class DrawerMenu extends Drawer {
  DrawerMenu()
      : super(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfilePictureNameNickVerticalWidget(
                    profileModel: UserModel(
                      avatar: "assets/profile-pictures/at.jpg",
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
                    child: ProjectLogos.flutterTwitterClone,
                  )
                ],
              ),
            ),
          ),
        );
}
