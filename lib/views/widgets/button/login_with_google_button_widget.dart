import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class LoginWithGoogleButtonWidget extends StatelessWidget {
  final Function() onPressed;
  LoginWithGoogleButtonWidget({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: ProjectColors.white,
      onPressed: onPressed,
      child: Container(
        height: 60,
        child: Row(
          children: [
            ProjectIcons.googleIcon,
            SizedBox(width: 20),
            Text(
              "Log in with Google",
              style: Styles.body2Gray,
            )
          ],
        ),
      ),
    );
  }
}
