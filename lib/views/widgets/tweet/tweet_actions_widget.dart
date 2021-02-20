import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/assets.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class TweetActionsWidget extends StatelessWidget {
  final int totalComments;
  final int totalRetweets;
  final int totalLikes;

  TweetActionsWidget({
    @required this.totalComments,
    @required this.totalRetweets,
    @required this.totalLikes,
  });

  Widget _getActionButton(String actionIcon, int total) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Image.asset(actionIcon),
            SizedBox(width: 5),
            Text(total.toString(), style: Styles.caption)
          ],
        ),
      ),
      onTap: () {
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _commentWidget = _getActionButton(AssetsIcons.comment, totalComments);
    var _retweetWidget = _getActionButton(AssetsIcons.retweet, totalRetweets);
    var _likesWidget = _getActionButton(AssetsIcons.heart, totalLikes);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _commentWidget,
        _retweetWidget,
        _likesWidget,
      ],
    );
  }
}
