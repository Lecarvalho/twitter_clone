import 'package:flutter/material.dart';
import 'package:twitter_clone/view/project_typography.dart';

class FollowingFollowersCountWidget extends StatelessWidget {
  final int totalFollowing;
  final int totalFollowers;

  FollowingFollowersCountWidget({
    @required this.totalFollowers,
    @required this.totalFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(totalFollowing.toString()),
        SizedBox(width: 3),
        Text(
          "Following",
          style: ProjectTypography.body2Gray,
        ),
        SizedBox(width: 10),
        Text(totalFollowers.toString()),
        SizedBox(width: 3),
        Text(
          "Followers",
          style: ProjectTypography.body2Gray,
        )
      ],
    );
  }
}
