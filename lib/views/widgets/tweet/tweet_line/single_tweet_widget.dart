import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import '../tweet_actions/tweet_actions_widget.dart';
import '../tweet_reaction_widget.dart';
import 'tweet_scaffold_widget.dart';

class SingleTweetWidget extends TweetScaffoldWidget {
  final TweetModel tweet;
  final String myProfileId;
  final Function() onLike;
  final Function()? onRetweet;

  SingleTweetWidget({
    required this.myProfileId,
    required this.tweet,
    required this.onLike,
    this.onRetweet,
  }) : super(
          asTweet: tweet,
        );

  @override
  Widget get reaction => TweetReactionWidget(
        tweetReaction: tweet.tweetReaction,
        myProfileId: myProfileId,
      );

  @override
  Widget get actions => TweetActionsWidget(
        tweet: tweet,
        onHeart: onLike,
        onRetweet: onRetweet,
      );
}
