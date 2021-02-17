import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/profile_name_widget.dart';
import 'package:twitter_clone/views/widgets/profile_nickname_widget.dart';
import 'package:twitter_clone/views/widgets/profile_picture_widget.dart';

class ProfilePictureNameNickVerticalWidget extends StatelessWidget {
  final ProfileModel profileModel;

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
        ProfileNameWidget(
          profileName: profileModel.profileName,
          textStyle: Styles.h5,
        ),
        SizedBox(height: 3),
        ProfileNicknameWidget(
          profileNickname: profileModel.profileNickname,
          textStyle: Styles.body1Gray,
        ),
      ],
    );
  }
}
