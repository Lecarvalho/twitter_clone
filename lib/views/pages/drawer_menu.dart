import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/widgets/tweet/following_followers_count_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_name_nick_vertical_widget.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  late ProfileController _profileController;
  late UserController _userController;
  @override
  void didChangeDependencies() async {
    _profileController = Di.instanceOf(context);
    _userController = Di.instanceOf(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePictureNameNickVerticalWidget(profile: _profileController.myProfile),
              SizedBox(height: 10),
              FollowingFollowersCountWidget(
                followersCount: _profileController.myProfile.followersCount!,
                followingCount: _profileController.myProfile.followingCount,
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  _userController.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                },
                child: Text("Logoff"),
              ),
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
}
