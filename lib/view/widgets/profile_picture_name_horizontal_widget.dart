import 'package:flutter/material.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';
import 'profile_picture_widget.dart';

class ProfilePictureNameHorizontalWidget extends StatelessWidget {
  final String photoUrl;
  final String profileName;
  final String profileNickName;

  ProfilePictureNameHorizontalWidget({
    @required this.photoUrl,
    @required this.profileName,
    @required this.profileNickName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePictureWidget(
          photoUrl: this.photoUrl,
          profilePicSize: ProfilePicSize.medium,
        ),
        SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileNameWidget(
              profileName: this.profileName,
              profileNameSize: ProfileNameSize.small,
            ),
            ProfileNickNameWidget(profileNickName: this.profileNickName)
          ],
        )
      ],
    );
  }
}
