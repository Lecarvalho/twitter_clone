import 'package:flutter/material.dart';
import 'package:twitter_clone/models/as_tweet_model_base.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';

abstract class TweetScaffoldWidget extends StatelessWidget {
  final AsTweetModelBase asTweet;

  TweetScaffoldWidget({
    required this.asTweet
  });

  Widget get reaction => Container();
  Widget get replyingTo => Container();
  Widget get actions => Container();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        reaction,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              avatar: asTweet.profile.avatar!,
              profilePicSize: ProfilePicSize.small2,
              profileId: asTweet.profileId,
              onTap: () => Navigator.of(context).pushNamed(
                Routes.profile,
                arguments: asTweet.profileId,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: asTweet.profile.name,
                    profileNickname: asTweet.profile.nicknameWithAt,
                    timeAgo: asTweet.creationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  replyingTo,
                  Text(asTweet.text, style: Styles.body2),
                  SizedBox(height: 5),
                  actions,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
