import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/models/comment_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';
import 'replying_to_line_widget.dart';

class TweetCommentWidget extends StatelessWidget {
  final CommentModel commentModel;
  final String replyingToNickname;
  TweetCommentWidget({
    @required this.commentModel,
    @required this.replyingToNickname,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              avatar: commentModel.userModel.avatar,
              profilePicSize: ProfilePicSize.small2,
              userId: commentModel.userId,
              onTap: () => Navigator.of(context).pushNamed(
                Routes.profile,
                arguments: commentModel.userId,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: commentModel.userModel.name,
                    profileNickname: commentModel.userModel.nickname,
                    timeAgo: commentModel.creationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  ReplyingToLineWidget(
                    profileNickname: replyingToNickname,
                  ),
                  SizedBox(height: 5),
                  Text(commentModel.text, style: Styles.body2)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
