import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/colors.dart';
import 'package:twitter_clone/view/resources/styles.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String text;

  OutlinedButtonWidget({
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text, style: Styles.subtitle2Blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: ProjectColors.blueActive),
      ),
      onPressed: onPressed,
    );
  }
}
