import 'package:flutter/material.dart';

class BaseButtonWidget extends MaterialButton {
  // final Function()? onPressed;
  // final String text;
  // final ShapeBorder shape;
  // final Color? color;
  // final Color? disabledColor;
  // final TextStyle textStyle;
  // final double? height;

  BaseButtonWidget({
    Function()? onPressed,
    required String text,
    required ShapeBorder shape,
    required TextStyle textStyle,
    Color? color,
    Color? disabledColor,
    double? height,
    double elevation = 0,
  }) : super(
          height: height,
          child: Text(text, style: textStyle),
          shape: shape,
          onPressed: onPressed,
          disabledColor: disabledColor,
          minWidth: 70,
          elevation: elevation,
        );
}
