import 'package:flutter/material.dart';
import 'package:twitter_clone/models/reply_model.dart';

import '../divider_widget.dart';
import 'tweet_line/tweet_reply_widget.dart';

class ReplyListWidget extends StatelessWidget {
  final List<ReplyModel>? replies;
  final String replyingToNickname;

  ReplyListWidget({
    required this.replies,
    required this.replyingToNickname,
  });

  @override
  Widget build(BuildContext context) {
    return replies != null
        ? ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (_, index) => Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TweetReplyWidget(
                reply: replies![index],
                replyingToNickname: replyingToNickname,
              ),
            ),
            separatorBuilder: (_, __) => DividerWidget(),
            itemCount: replies!.length,
          )
        : Container();
  }
}
