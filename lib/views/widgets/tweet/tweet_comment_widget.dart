import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/models/comment_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';
import 'replying_to_line_widget.dart';

class TweetCommentWidget extends StatelessWidget {
  final CommentModel comment;
  final String replyingToNickname;
  TweetCommentWidget({
    @required this.comment,
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
              avatar: comment.profile.avatar,
              profilePicSize: ProfilePicSize.small2,
              profileId: comment.profileId,
              onTap: () => Navigator.of(context).pushNamed(
                Routes.profile,
                arguments: comment.profileId,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: comment.profile.name,
                    profileNickname: comment.profile.nickname,
                    timeAgo: comment.creationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  ReplyingToLineWidget(
                    profileNickname: replyingToNickname,
                  ),
                  SizedBox(height: 5),
                  Text(comment.text, style: Styles.body2)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
