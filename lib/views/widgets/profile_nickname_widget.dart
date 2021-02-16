import 'package:flutter/material.dart';

class ProfileNicknameWidget extends StatelessWidget {
  final String profileNickName;
  final TextStyle textStyle;

  ProfileNicknameWidget({
    @required this.profileNickName,
    @required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        profileNickName,
        style: textStyle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
