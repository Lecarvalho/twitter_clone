import 'package:flutter/material.dart';

class ProfileNicknameWidget extends StatelessWidget {
  final String profileNickname;
  final TextStyle textStyle;

  ProfileNicknameWidget({
    @required this.profileNickname,
    @required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        profileNickname,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
