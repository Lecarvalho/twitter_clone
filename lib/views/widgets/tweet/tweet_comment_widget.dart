import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';
import 'replying_to_line_widget.dart';

class TweetCommentWidget extends StatelessWidget {
  final TweetModel tweetModel;
  final String replyingToNickname;
  TweetCommentWidget({@required this.tweetModel, @required this.replyingToNickname});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              avatar: tweetModel.userModel.avatar,
              profilePicSize: ProfilePicSize.small2,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: tweetModel.userModel.name,
                    profileNickname: tweetModel.userModel.nickname,
                    timeAgo: tweetModel.creationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  ReplyingToLineWidget(
                    profileNickname: replyingToNickname,
                  ),
                  SizedBox(height: 5),
                  Text(tweetModel.text, style: Styles.body2)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
