import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_nick_vertical_widget.dart';
import 'profile_picture_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserModel userModel;
  ProfileHeaderWidget({@required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureWidget(
          avatar: userModel.avatar,
          profilePicSize: ProfilePicSize.large,
        ),
        SizedBox(height: 10),
        ProfileNameNickVerticalWidget(
          profileName: userModel.name,
          profileNickname: userModel.nickname,
        ),
        SizedBox(height: 10),
        Text(userModel.bio),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.date_range, color: ProjectColors.gray),
            SizedBox(width: 5),
            Text(
              "Joined ${userModel.inscriptionDateMonthYear}",
              style: Styles.body2Gray,
            ),
          ],
        )
      ],
    );
  }
}
