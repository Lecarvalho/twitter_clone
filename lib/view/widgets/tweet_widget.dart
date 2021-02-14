import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/view/resources/metadata.dart';
import 'package:twitter_clone/view/resources/styles.dart';

import 'profile_picture_name_horizontal_widget.dart';

class TweetWidget extends StatelessWidget {
  final String photoUrl;
  final String profileName;
  final String profileNickName;
  final String tweetText;
  final DateTime dateTimeTweet;

  TweetWidget({
    @required this.photoUrl,
    @required this.profileName,
    @required this.profileNickName,
    @required this.tweetText,
    @required this.dateTimeTweet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePictureNameHorizontalWidget(
          photoUrl: photoUrl,
          profileName: profileName,
          profileNickName: profileNickName,
        ),
        SizedBox(height: 20),
        Text(tweetText, style: Styles.h5),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              DateFormat.Hm().add_yMd().format(dateTimeTweet),
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
