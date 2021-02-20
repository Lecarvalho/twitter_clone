import 'package:flutter/material.dart';
import 'package:twitter_clone/models/user_model.dart';

import 'profile_name_nick_vertical_widget.dart';
import 'profile_picture_widget.dart';

class ProfilePictureNameNickVerticalWidget extends StatelessWidget {
  final UserModel profileModel;

  ProfilePictureNameNickVerticalWidget({@required this.profileModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureWidget(
          photoUrl: profileModel.photoUrl,
          profilePicSize: ProfilePicSize.medium,
        ),
        SizedBox(height: 10),
        ProfileNameNickVerticalWidget(
          profileName: profileModel.name,
          profileNickname: profileModel.nickname,
        ),
      ],
    );
  }
}
