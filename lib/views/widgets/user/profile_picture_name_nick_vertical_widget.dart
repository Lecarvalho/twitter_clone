import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
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
          avatar: profileModel.avatar,
          profilePicSize: ProfilePicSize.medium,
          userId: profileModel.id,
          onTap: () => Navigator.of(context).pushNamed(
            Routes.profile,
            arguments: profileModel.id,
          ),
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
