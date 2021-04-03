import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';

import 'base_button_widget.dart';
import 'shapes.dart';

class ButtonWidget extends BaseButtonWidget {
  final Function()? onPressed;
  final String text;

  ButtonWidget({
    this.onPressed,
    required this.text,
  }) : super(
          onPressed: onPressed,
          height: 30,
          text: text,
          textStyle: Styles.subtitle2White,
          color: ProjectColors.blueActive,
          disabledColor: ProjectColors.blueInactive,
          shape: Shapes.rounded(),
        );
}
