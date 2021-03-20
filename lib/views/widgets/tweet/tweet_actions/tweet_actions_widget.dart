import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'reply_icon_widget.dart';
import 'heart_icon_widget.dart';
import 'retweet_icon_widget.dart';

class TweetActionsWidget extends StatelessWidget {
  final TweetModel tweet;
  final Function() onHeart;
  final Function()? onRetweet;

  TweetActionsWidget({
    required this.tweet,
    required this.onHeart,
    this.onRetweet,
  });

  void _onTapComment(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.reply, arguments: tweet);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReplyIconWidget(
          isReplyed: false,
          repliesCount: tweet.repliesCount,
          onReply: () => _onTapComment(context),
        ),
        SizedBox(width: 25),
        RetweetIconWidget(
          didIRetweet: tweet.didIRetweet,
          onRetweet: onRetweet,
          retweetCount: tweet.retweetCount,
        ),
        SizedBox(width: 25),
        HeartIconWidget(
          didILike: tweet.didILike,
          likeCount: tweet.likeCount,
          onHeart: onHeart,
        ),
      ],
    );
  }
}
