import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'base_button_widget.dart';
import 'shapes.dart';

class TapToUpdateButtonWidget extends StatelessWidget {
  final Function() onPressed;
  TapToUpdateButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        alignment: Alignment.topCenter,
        child: BaseButtonWidget(
          shape: Shapes.rounded(),
          text: "Tap to update the feed",
          color: ProjectColors.blueActive,
          height: 30,
          onPressed: onPressed,
          textStyle: Styles.subtitle2White,
          elevation: 2,
        ),
      ),
    );
  }
}
