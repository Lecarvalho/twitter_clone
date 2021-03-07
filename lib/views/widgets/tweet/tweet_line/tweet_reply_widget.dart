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
          avatar: reply.profile.avatar,
          profileId: reply.profileId,
          profileName: reply.profile.name,
          profileNickname: reply.profile.nickname,
          tweetCreationTimeAgo: reply.creationTimeAgo,
          tweetId: reply.id,
          text: reply.text,
        );

  @override
  Widget get replyingTo => ReplyingToLineWidget(
                    profileNickname: replyingToNickname,
                  );
}
