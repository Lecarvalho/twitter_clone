import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/metadata.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/profile_picture_name_nick_horizontal_widget.dart';

class TweetBigSingleWidget extends StatelessWidget {
  final TweetModel tweetModel;

  TweetBigSingleWidget({@required this.tweetModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureNameNickHorizontalWidget(
          profileModel: tweetModel.profileModel,
        ),
        SizedBox(height: 15),
        Text(tweetModel.tweetText, style: Styles.h5),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              tweetModel.dateLong,
              style: Styles.body2Gray,
            ),
            Text("-", style: Styles.body2Gray),
            Text(Metadata.projectName, style: Styles.body2Blue),
          ],
        )
      ],
    );
  }
}
