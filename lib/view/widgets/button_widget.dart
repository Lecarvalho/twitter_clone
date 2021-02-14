import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/colors.dart';
import 'package:twitter_clone/view/resources/styles.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String text;

  ButtonWidget({
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: ProjectColors.blueActive,
      disabledColor: ProjectColors.blueInactive,
      child: Text(text, style: Styles.subtitle2White),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
