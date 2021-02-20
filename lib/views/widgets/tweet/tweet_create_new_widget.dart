import 'package:flutter/material.dart';

import 'write_tweet_widget.dart';

class TweetCreateNewWidget extends StatelessWidget {
  final controller = TextEditingController();
  final String photoUrl;

  TweetCreateNewWidget({@required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return WriteTweetWidget(
      controller: controller,
      hintText: "What's happening?",
      photoUrl: photoUrl,
    );
  }
}
