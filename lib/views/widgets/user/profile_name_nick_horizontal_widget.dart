import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';

class ProfileNameNickHorizontalWidget extends StatelessWidget {

  final String profileName;
  final String profileNickname;

  ProfileNameNickHorizontalWidget({
    @required this.profileName,
    @required this.profileNickname,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileNameWidget(
          profileName: profileName,
          textStyle: Styles.subtitle2,
        ),
        SizedBox(width: 5),
        ProfileNicknameWidget(
          profileNickname: profileNickname,
          textStyle: Styles.body2Gray,
        ),
      ],
    );
  }
}
