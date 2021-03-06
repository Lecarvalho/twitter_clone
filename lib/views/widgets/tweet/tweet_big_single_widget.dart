import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_name_nick_horizontal_widget.dart';

class TweetBigSingleWidget extends StatelessWidget {
  final TweetModel tweet;

  TweetBigSingleWidget({required this.tweet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePictureNameNickHorizontalWidget(
            profile: tweet.profile,
          ),
          SizedBox(height: 15),
          Text(tweet.text, style: Styles.h5),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                tweet.creationDateLong,
                style: Styles.body2Gray,
              ),
              Text("-", style: Styles.body2Gray),
              Text(AppConfig.projectName, style: Styles.body2Blue),
            ],
          )
        ],
      ),
    );
  }
}
