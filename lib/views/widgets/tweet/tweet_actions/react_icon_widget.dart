import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

abstract class ReactIconWidget extends StatelessWidget {
  final int reactCount;
  final bool isReacted;
  final Function()? onTap;

  ReactIconWidget({
    required this.isReacted,
    required this.reactCount,
    this.onTap,
  });

  Widget get icon => isReacted ? reactedIcon : defaultIcon;
  Widget get text => isReacted ? reactedText : defaultText;

  Widget get reactedText => Text(
        reactCount.toString(),
        style: Styles.caption.apply(color: reactionColor),
      );

  Widget get defaultText => Text(
        reactCount.toString(),
        style: Styles.caption,
      );

  Widget get reactedIcon;
  Widget get defaultIcon;
  Color get reactionColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: ProjectColors.transparent,
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 10,
          left: 10,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 5),
            text,
          ],
        ),
      ),
      onTap: onTap,
      onDoubleTap: () async {
        if (onTap != null) {
          await Future.delayed(Duration(seconds: 1));
          onTap!;
        }
      },
    );
  }
}
