import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/button/base_button_widget.dart';

import 'shapes.dart';

class OutlinedButtonWidget extends BaseButtonWidget {
  final Function() onPressed;
  final String text;

  OutlinedButtonWidget({
    required this.onPressed,
    required this.text,
  }) : super(
          height: 30,
          text: text,
          textStyle: Styles.subtitle2Blue,
          color: ProjectColors.white,
          onPressed: onPressed,
          shape: Shapes.roundedBordered(),
        );
}
