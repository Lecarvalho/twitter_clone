import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_reaction_model.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class TweetReactionWidget extends StatelessWidget {
  final TweetReactionModel? tweetReaction;
  final String myProfileId;

  TweetReactionWidget({
    required this.tweetReaction,
    required this.myProfileId,
  });

  String get _whoReacted => tweetReaction != null
      ? tweetReaction!.reactedByProfileId == myProfileId
          ? "You"
          : tweetReaction!.reactedByProfileName
      : "";

  Widget _getReactionDescription() {
    Image icon;
    String reaction;

    switch (tweetReaction!.reactionType) {
      case TweetReactionType.like:
        icon = ProjectIcons.likeSolidDarken;
        reaction = "liked";
        break;
      case TweetReactionType.retweet:
        icon = ProjectIcons.retweet;
        reaction = "retweeted";
        break;
    }

    return Padding(
      padding: EdgeInsets.only(left: 40, bottom: 7),
      child: Row(
        children: [
          icon,
          SizedBox(width: 5),
          Text(_whoReacted + " " + reaction, style: Styles.subtitle2Gray),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tweetReaction != null ? _getReactionDescription() : Container();
  }
}
