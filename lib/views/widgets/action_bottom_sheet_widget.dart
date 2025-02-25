import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';

class ActionBottomSheetWidget extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function() onPressed;

  ActionBottomSheetWidget({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: ProjectColors.transparent,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: icon,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
