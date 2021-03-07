import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class ReplyingToLineWidget extends StatelessWidget {
  final String profileNickname;
  ReplyingToLineWidget({required this.profileNickname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          text: "Replying to ",
          style: Styles.body2Gray,
          children: [
            TextSpan(
              text: profileNickname,
              style: Styles.body2Blue,
            ),
          ],
        ),
      ),
    );
  }
}
