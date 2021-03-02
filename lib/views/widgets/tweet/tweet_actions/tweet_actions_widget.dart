import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import 'comment_icon_widget.dart';
import 'heart_icon_widget.dart';
import 'retweet_icon_widget.dart';

class TweetActionsWidget extends StatelessWidget {
  final TweetModel tweet;
  final Function() onHeart;
  final Function() onRetweet;

  TweetActionsWidget({
    @required this.tweet,
    @required this.onHeart,
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
        CommentIconWidget(
          isCommented: false,
          commentCount: tweet.commentCount,
          onComment: () => _onTapComment(context),
        ),
        RetweetIconWidget(
          isRetweeted: tweet.isRetweeted,
          onRetweet: onRetweet,
          retweetCount: tweet.retweetCount,
        ),
        HeartIconWidget(
          isHearted: tweet.isHearted,
          heartCount: tweet.heartCount,
          onHeart: onHeart,
        ),
      ],
    );
  }
}
