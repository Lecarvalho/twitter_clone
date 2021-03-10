import 'package:flutter/material.dart';
import 'package:twitter_clone/models/reply_model.dart';

import '../replying_to_line_widget.dart';
import 'tweet_scaffold_widget.dart';

class TweetReplyWidget extends TweetScaffoldWidget {
  final ReplyModel reply;
final String replyingToNickname;

  TweetReplyWidget({
    required this.reply,
    required this.replyingToNickname,
  }) : super(
          asTweet: reply,
        );

  @override
  Widget get replyingTo => ReplyingToLineWidget(
                    profileNickname: replyingToNickname,
                  );
}
