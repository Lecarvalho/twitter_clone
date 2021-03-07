import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';

import '../tweet_actions/tweet_actions_widget.dart';
import '../tweet_activity_widget.dart';
import 'tweet_scaffold_widget.dart';

class SingleTweetWidget extends TweetScaffoldWidget {
  final TweetModel tweet;
  final Function() onHeart;
  final Function()? onRetweet;

  SingleTweetWidget({
    required this.tweet,
    required this.onHeart,
    this.onRetweet,
  }) : super(
          avatar: tweet.profile.avatar,
          profileId: tweet.profileId,
          profileName: tweet.profile.name,
          profileNickname: tweet.profile.nickname,
          tweetCreationTimeAgo: tweet.creationTimeAgo,
          tweetId: tweet.id,
          text: tweet.text,
        );

  @override
  Widget get activity => TweetActivityWidget(
        tweetActivity: tweet.tweetActivity,
      );

  @override
  Widget get actions => TweetActionsWidget(
        tweet: tweet,
        onHeart: onHeart,
        onRetweet: onRetweet,
      );
}
