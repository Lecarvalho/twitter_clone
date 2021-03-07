import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/views/widgets/user/profile_name_nick_timeago_horizontal_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_picture_widget.dart';

abstract class TweetScaffoldWidget extends StatelessWidget {
  final String avatar;
  final String tweetId;
  final String profileId;
  final String profileName;
  final String profileNickname;
  final String tweetCreationTimeAgo;
  final String text;

  TweetScaffoldWidget({
    required this.avatar,
    required this.tweetId,
    required this.profileId,
    required this.profileName,
    required this.profileNickname,
    required this.tweetCreationTimeAgo,
    required this.text,
  });

  Widget get activity => Container();
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
        activity,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePictureWidget(
              avatar: avatar,
              profilePicSize: ProfilePicSize.small2,
              profileId: profileId,
              onTap: () => Navigator.of(context).pushNamed(
                Routes.profile,
                arguments: tweetId,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileNameNickTimeAgoHorizontalWidget(
                    profileName: profileName,
                    profileNickname: profileNickname,
                    timeAgo: tweetCreationTimeAgo,
                  ),
                  SizedBox(height: 5),
                  replyingTo,
                  Text(text, style: Styles.body2),
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
