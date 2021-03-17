import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_activity_model.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class TweetActivityWidget extends StatelessWidget {
  final TweetActivityModel? tweetActivity;
  final String myProfileId;

  TweetActivityWidget({
    required this.tweetActivity,
    required this.myProfileId,
  });

  String get _whoReacted => tweetActivity != null
      ? tweetActivity!.reactedByProfileId == myProfileId
          ? "You"
          : tweetActivity!.profileName
      : "";

  Widget _getActionDescription() {
    Image icon;
    String action;

    switch (tweetActivity!.tweetAction) {
      case TweetAction.like:
        icon = ProjectIcons.heartSolidDarken;
        action = "liked";
        break;
      case TweetAction.retweet:
        icon = ProjectIcons.retweet;
        action = "retweeted";
        break;
    }

    return Padding(
      padding: EdgeInsets.only(left: 40, bottom: 7),
      child: Row(
        children: [
          icon,
          SizedBox(width: 7),
          Text(_whoReacted + " " + action, style: Styles.subtitle2Gray),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return tweetActivity != null ? _getActionDescription() : Container();
  }
}
