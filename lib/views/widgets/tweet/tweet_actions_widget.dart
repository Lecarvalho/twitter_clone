import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class TweetActionsWidget extends StatelessWidget {

  final TweetModel tweetModel;

  TweetActionsWidget({
    @required this.tweetModel,
  });

  Widget _getActionButton(Image actionIcon, int total, Function() onTap) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Row(
          children: [
            actionIcon,
            SizedBox(width: 5),
            Text(total.toString(), style: Styles.caption)
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  void _onTapComment(BuildContext context){
    Navigator.of(context).pushNamed(Routes.reply, arguments: tweetModel);
  }

  void _onTapRetweet(){

  } 

  void _onTapLike(){

  }

  @override
  Widget build(BuildContext context) {
    var _commentWidget = _getActionButton(ProjectIcons.comment, tweetModel.commentCount, () => _onTapComment(context));
    var _retweetWidget = _getActionButton(ProjectIcons.retweet, tweetModel.retweetCount, _onTapRetweet);
    var _likesWidget = _getActionButton(ProjectIcons.heart, tweetModel.heartCount, _onTapLike);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _commentWidget,
        _retweetWidget,
        _likesWidget,
      ],
    );
  }
}
