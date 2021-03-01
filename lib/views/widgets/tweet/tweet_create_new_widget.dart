import 'package:flutter/material.dart';

import 'write_tweet_widget.dart';

class TweetCreateNewWidget extends StatelessWidget {
  final TextEditingController controller;
  final String avatar;
  final String myProfileId;

  TweetCreateNewWidget({
    @required this.avatar,
    @required this.myProfileId,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return WriteTweetWidget(
      controller: controller,
      hintText: "What's happening?",
      avatar: avatar,
      myProfileId: myProfileId,
    );
  }
}
