import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/button/base_button_widget.dart';

class OutlinedButtonWidget extends BaseButtonWidget {
  final Function() onPressed;
  final String text;

  OutlinedButtonWidget({
    @required this.onPressed,
    @required this.text,
  }) : super(
          text: text,
          textStyle: Styles.subtitle2Blue,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: ProjectColors.blueActive),
          ),
        );
}
