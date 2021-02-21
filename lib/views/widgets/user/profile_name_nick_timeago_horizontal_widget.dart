import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_widget.dart';
import 'profile_nickname_widget.dart';

class ProfileNameNickTimeAgoHorizontalWidget extends StatelessWidget {
  final String profileName;
  final String profileNickname;
  final String timeAgo;

  ProfileNameNickTimeAgoHorizontalWidget({
    @required this.profileName,
    @required this.profileNickname,
    @required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileNameWidget(
          profileName: profileName,
          textStyle: Styles.subtitle1,
        ),
        SizedBox(width: 5),
        ProfileNicknameWidget(
          profileNickname: profileNickname,
          textStyle: Styles.body2Gray,
        ),
        Text(" · $timeAgo", style: Styles.body2Gray),
      ],
    );
  }
}
