import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class ReplyingToLineWidget extends StatelessWidget {
  final String profileNickname;
  ReplyingToLineWidget({@required this.profileNickname});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Replying to", style: Styles.body2Gray),
        Text(profileNickname, style: Styles.body2Blue),
      ],
    );
  }
}
