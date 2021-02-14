import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/styles.dart';

class ProfileNickNameWidget extends StatelessWidget {
  final String profileNickName;
  ProfileNickNameWidget({@required this.profileNickName});

  @override
  Widget build(BuildContext context) {
    return Text(profileNickName, style: Styles.subtitle1Gray);
  }
}
