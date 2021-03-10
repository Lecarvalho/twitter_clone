import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';
import 'profile_picture_widget.dart';

class ProfilePictureNameNickHorizontalWidget extends StatelessWidget {
  final ProfileModel profile;

  ProfilePictureNameNickHorizontalWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePictureWidget(
          avatar: profile.avatar!,
          profilePicSize: ProfilePicSize.small2,
          profileId: profile.id,
          onTap: () => Navigator.of(context).pushNamed(
            Routes.profile,
            arguments: profile.id,
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileNameWidget(
              profileName: profile.name,
              textStyle: Styles.subtitle1,
            ),
            SizedBox(height: 5),
            ProfileNicknameWidget(
              profileNickname: profile.nickname!,
              textStyle: Styles.subtitle1Gray,
            )
          ],
        )
      ],
    );
  }
}
