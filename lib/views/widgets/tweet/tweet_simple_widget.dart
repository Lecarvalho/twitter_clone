import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';

import 'tweet_actions/tweet_actions_widget.dart';
import 'tweet_activity_widget.dart';

class TweetSimpleWidget extends StatelessWidget {
  final TweetModel tweet;
  final Function() onHeart;
  final Function()? onRetweet;

  TweetSimpleWidget({
    required this.tweet,
    required this.onHeart,
    this.onRetweet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        TweetActivityWidget(tweetActivity: tweet.tweetActivity),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              avatar: tweet.profile.avatar,
              profilePicSize: ProfilePicSize.small2,
              profileId: tweet.profileId,
              onTap: () => Navigator.of(context).pushNamed(
                Routes.profile,
                arguments: tweet.id,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: tweet.profile.name,
                    profileNickname: tweet.profile.nickname,
                    timeAgo: tweet.creationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  Text(tweet.text, style: Styles.body2),
                  SizedBox(height: 5),
                  TweetActionsWidget(
                    tweet: tweet,
                    onHeart: onHeart,
                    onRetweet: onRetweet,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
