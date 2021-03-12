import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/button/base_button_widget.dart';

import 'profile_name_nick_vertical_widget.dart';
import 'profile_picture_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final ProfileModel profile;
  final BaseButtonWidget actionButton;
  ProfileHeaderWidget({
    required this.profile,
    required this.actionButton,
  });

  Widget _underflowAppBar() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        backgroundColor: ProjectColors.blueActive,
        toolbarHeight: 90,
        elevation: 0,
        iconTheme: IconThemeData(color: ProjectColors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _underflowAppBar(),
        Padding(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePictureWidget(
                    avatar: profile.avatar!,
                    profilePicSize: ProfilePicSize.large,
                    profileId: profile.id,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: actionButton,
                  )
                ],
              ),
              SizedBox(height: 10),
              ProfileNameNickVerticalWidget(
                profileName: profile.name,
                profileNickname: profile.nicknameWithAt,
              ),
              SizedBox(height: 10),
              Text(profile.bio!),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.date_range, color: ProjectColors.gray),
                  SizedBox(width: 5),
                  Text(
                    "Joined ${profile.createdAtDateMonthYear}",
                    style: Styles.body2Gray,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
