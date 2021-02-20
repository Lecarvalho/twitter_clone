import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'base_button_widget.dart';

class ButtonWidget extends BaseButtonWidget {
  final Function() onPressed;
  final String text;

  ButtonWidget({
    @required this.onPressed,
    @required this.text,
  }) : super(
          onPressed: onPressed,
          text: text,
          textStyle: Styles.subtitle2White,
          color: ProjectColors.blueActive,
          disabledColor: ProjectColors.blueInactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
}
