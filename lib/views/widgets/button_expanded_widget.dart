import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

class ButtonExpandedWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  ButtonExpandedWidget({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: FlatButton(
        onPressed: onPressed,
        color: ProjectColors.grayBackground,
        disabledColor: ProjectColors.blueInactive,
        child: Text(text, style: Styles.subtitle2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
