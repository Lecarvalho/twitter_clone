import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'base_button_widget.dart';

class ButtonActionBarWidget extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  ButtonActionBarWidget({
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 12, right: 20),
      child: BaseButtonWidget(
        onPressed: onPressed,
        text: text,
        color: ProjectColors.blueActive,
        disabledColor: ProjectColors.blueInactive,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: Styles.subtitle2White,
      ),
    );
  }
}
