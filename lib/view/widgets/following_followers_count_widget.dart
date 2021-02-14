import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/styles.dart';

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
          style: Styles.body2Gray,
        ),
        SizedBox(width: 10),
        Text(totalFollowers.toString()),
        SizedBox(width: 3),
        Text(
          "Followers",
          style: Styles.body2Gray,
        )
      ],
    );
  }
}
