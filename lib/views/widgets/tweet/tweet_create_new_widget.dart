import 'package:flutter/material.dart';

import 'write_tweet_widget.dart';

class TweetCreateNewWidget extends StatelessWidget {
  final controller = TextEditingController();
  final String avatar;
  final String myUserId;

  TweetCreateNewWidget({
    @required this.avatar,
    @required this.myUserId,
  });

  @override
  Widget build(BuildContext context) {
    return WriteTweetWidget(
      controller: controller,
      hintText: "What's happening?",
      avatar: avatar,
      userId: myUserId,
    );
  }
}
