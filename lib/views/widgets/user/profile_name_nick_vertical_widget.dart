import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';

class ProfileNameNickVerticalWidget extends StatelessWidget {
  final String profileName;
  final String profileNickname;

  ProfileNameNickVerticalWidget({
    required this.profileName,
    required this.profileNickname,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileNameWidget(
          profileName: profileName,
          textStyle: Styles.h6,
        ),
        SizedBox(height: 3),
        ProfileNicknameWidget(
          profileNickname: profileNickname,
          textStyle: Styles.body2Gray,
        ),
      ],
    );
  }
}
