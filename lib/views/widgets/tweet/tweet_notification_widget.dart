import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/models/tweet_notification_model.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';

class TweetNotificationWidget extends StatelessWidget {
  final TweetNotificationModel tweetNotification;
  TweetNotificationWidget({required this.tweetNotification});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: ProjectIcons.starSolid,
          top: 10,
          left: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePictureWidget(
                avatar: tweetNotification.tweet.profile.avatar,
                profileId: tweetNotification.tweet.profileId,
                profilePicSize: ProfilePicSize.small2,
                onTap: () => Navigator.of(context).pushNamed(
                  Routes.home,
                  arguments: tweetNotification.tweet.profileId,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "In case you missed ",
                  style: Styles.body2Gray,
                  children: [
                    TextSpan(
                      text: tweetNotification.tweet.profile.name,
                      style: Styles.subtitle1,
                    ),
                    TextSpan(text: " tweet"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(tweetNotification.tweet.text, style: Styles.body2Gray),
            ],
          ),
        ),
      ],
    );
  }
}
