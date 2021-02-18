import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';

import 'multiline_textbox_widget.dart';
import 'profile_picture_widget.dart';
import 'replying_to_line_widget.dart';

class TweetReplyToWidget extends StatelessWidget {
  final String replyingToNickname;
  final String photoUrl;
  final controller = TextEditingController();

  TweetReplyToWidget({
    @required this.replyingToNickname,
    @required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 50),
            ReplyingToLineWidget(profileNickname: replyingToNickname),
          ],
        ),
        SizedBox(height: 5),
        Row(
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
                hintText: "Tweet your reply",
                controller: controller,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
