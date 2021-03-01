import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/models/profile_model.dart';

import 'profile_name_nick_vertical_widget.dart';
import 'profile_picture_widget.dart';

class ProfilePictureNameNickVerticalWidget extends StatelessWidget {
  final ProfileModel profile;

  ProfilePictureNameNickVerticalWidget({@required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureWidget(
          avatar: profile.avatar,
          profilePicSize: ProfilePicSize.medium,
          profileId: profile.id,
          onTap: () => Navigator.of(context).pushNamed(
            Routes.profile,
            arguments: profile.id,
          ),
        ),
        SizedBox(height: 10),
        ProfileNameNickVerticalWidget(
          profileName: profile.name,
          profileNickname: profile.nickname,
        ),
      ],
    );
  }
}
