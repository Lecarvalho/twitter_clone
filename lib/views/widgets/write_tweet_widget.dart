import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';

import 'multiline_textbox_widget.dart';
import 'profile_picture_widget.dart';

class WriteTweetWidget extends StatelessWidget {
  final String photoUrl;
  final TextEditingController controller;
  final String hintText;

  WriteTweetWidget({
    @required this.photoUrl,
    @required this.controller,
    @required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: ProfilePictureWidget(
            photoUrl: photoUrl,
            profilePicSize: ProfilePicSize.small,
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: MultilineTextboxWidget(
            maxLength: AppConfig.limitCharacter,
            hintText: hintText,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
