import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'profile_name_nick_horizontal_widget.dart';
import 'profile_picture_widget.dart';
import 'replying_to_line_widget.dart';

class TweetCommentWidget extends StatelessWidget {
  final TweetModel tweetModel;
  TweetCommentWidget({@required this.tweetModel});

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
              photoUrl: tweetModel.profileModel.photoUrl,
              profilePicSize: ProfilePicSize.small2,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickHorizontalWidget(
                    profileName: tweetModel.profileModel.profileName,
                    profileNickname: tweetModel.profileModel.profileNickname,
                  ),
                  SizedBox(height: 5),
                  ReplyingToLineWidget(
                    profileNickname: tweetModel.profileModel.profileNickname,
                  ),
                  SizedBox(height: 5),
                  Text(tweetModel.tweetText, style: Styles.body2)
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
