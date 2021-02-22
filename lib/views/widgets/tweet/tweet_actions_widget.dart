import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';
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

  Widget _getActionButton(Image actionIcon, int total) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            actionIcon,
            SizedBox(width: 10),
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
    var _commentWidget = _getActionButton(ProjectIcons.comment, totalComments);
    var _retweetWidget = _getActionButton(ProjectIcons.retweet, totalRetweets);
    var _likesWidget = _getActionButton(ProjectIcons.heart, totalLikes);

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
