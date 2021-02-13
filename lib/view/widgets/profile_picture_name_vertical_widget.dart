import 'package:flutter/material.dart';
import 'package:twitter_clone/view/widgets/profile_name_widget.dart';
import 'package:twitter_clone/view/widgets/profile_nickname_widget.dart';
import 'package:twitter_clone/view/widgets/profile_picture_widget.dart';

class ProfilePictureNameVerticalWidget extends StatelessWidget {
  final String photoUrl;
  final String profileName;
  final String profileNickName;

  ProfilePictureNameVerticalWidget({
    @required this.photoUrl,
    @required this.profileName,
    @required this.profileNickName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureWidget(
          photoUrl: this.photoUrl,
          profilePicSize: ProfilePicSize.medium,
        ),
        SizedBox(height: 10),
        ProfileNameWidget(
          profileName: this.profileName,
          profileNameSize: ProfileNameSize.medium,
        ),
        SizedBox(height: 3),
        ProfileNickNameWidget(profileNickName: this.profileNickName)
      ],
    );
  }
}
