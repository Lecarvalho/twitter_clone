import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_activity_model.dart';
import 'package:twitter_clone/views/resources/assets.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class TweetActivityWidget extends StatelessWidget {
  final TweetActivityModel tweetActivityModel;

  TweetActivityWidget({
    @required this.tweetActivityModel,
  });

  Widget _getActionDescription() {

    Image icon;
    String action;

    switch (tweetActivityModel.tweetAction) {
      case TweetAction.liked:
        icon = Image.asset(AssetsIcons.heartSolidDarken);
        action = "liked";
        break;
      case TweetAction.retweeted:
        icon = Image.asset(AssetsIcons.retweet);
        action = "retweeted";
        break;
    }

    return Padding(
      padding: EdgeInsets.only(left: 45, bottom: 5),
      child: Row(
        children: [
          icon,
          SizedBox(width: 7),
          Text(tweetActivityModel.profileName + " " + action, style: Styles.subtitle2Gray),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getActionDescription();
  }
}

