import 'package:flutter/material.dart';

import 'replying_to_line_widget.dart';
import 'write_tweet_widget.dart';

class WriteReplyWidget extends StatelessWidget {
  final String replyingToNickname;
  final String avatar;
  final String myProfileId;
  final TextEditingController controller;

  WriteReplyWidget({
    required this.replyingToNickname,
    required this.avatar,
    required this.myProfileId,
    required this.controller,
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
        WriteTweetWidget(
          controller: controller,
          hintText: "Tweet your reply",
          avatar: avatar,
          myProfileId: myProfileId,
        ),
      ],
    );
  }
}
