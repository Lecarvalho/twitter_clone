import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';
import 'profile_picture_widget.dart';

class ProfilePictureNameNickHorizontalWidget extends StatelessWidget {
  final UserModel userModel;

  ProfilePictureNameNickHorizontalWidget({@required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePictureWidget(
          avatar: userModel.avatar,
          profilePicSize: ProfilePicSize.small2,
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileNameWidget(
              profileName: userModel.name,
              textStyle: Styles.subtitle1,
            ),
            SizedBox(height: 5),
            ProfileNicknameWidget(
              profileNickname: userModel.nickname,
              textStyle: Styles.subtitle1Gray,
            )
          ],
        )
      ],
    );
  }
}
