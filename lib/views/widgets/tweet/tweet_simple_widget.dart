import 'package:flutter/material.dart';
import 'package:twitter_clone/models/tweet_activity_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';

import 'tweet_actions_widget.dart';
import 'tweet_activity_widget.dart';

class TweetSimpleWidget extends StatelessWidget {
  final TweetModel tweetModel;
  final TweetActivityModel tweetActivityModel;

  TweetSimpleWidget({
    @required this.tweetModel,
    this.tweetActivityModel,
  });

  @override
  Widget build(BuildContext context) {
    Widget tweetActivityWidget = Container();

    if (tweetActivityModel != null) {
      tweetActivityWidget = TweetActivityWidget(
        tweetActivityModel: tweetActivityModel,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tweetActivityWidget,
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
                  ProfileNameNickHorizontalWidget(
                    profileName: tweetModel.userModel.name,
                    profileNickname: tweetModel.userModel.nickname,
                  ),
                  SizedBox(height: 5),
                  Text(tweetModel.text, style: Styles.body2),
                  TweetActionsWidget(
                    totalComments: 46,
                    totalRetweets: 18,
                    totalLikes: 363,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
