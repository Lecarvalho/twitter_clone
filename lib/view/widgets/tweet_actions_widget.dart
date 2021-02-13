import 'package:flutter/material.dart';
import 'package:twitter_clone/view/project_assets.dart';
import 'package:twitter_clone/view/project_typography.dart';

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
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Image.asset(actionIcon),
            SizedBox(width: 5),
            Text(total.toString(), style: ProjectTypography.caption)
          ],
        ),
      ),
      onTap: () {
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _commentWidget = _getActionButton(IconAssets.comment, totalComments);
    var _retweetWidget = _getActionButton(IconAssets.retweet, totalRetweets);
    var _likesWidget = _getActionButton(IconAssets.heart, totalLikes);

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
