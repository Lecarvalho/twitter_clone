import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class FollowingFollowersCountWidget extends StatelessWidget {
  final int followingCount;
  final int followersCount;

  FollowingFollowersCountWidget({
    required this.followersCount,
    required this.followingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(followingCount.toString(), style: Styles.subtitle1),
        SizedBox(width: 3),
        Text(
          "Following",
          style: Styles.body2Gray,
        ),
        SizedBox(width: 10),
        Text(followersCount.toString(), style: Styles.subtitle1),
        SizedBox(width: 3),
        Text(
          "Followers",
          style: Styles.body2Gray,
        )
      ],
    );
  }
}
