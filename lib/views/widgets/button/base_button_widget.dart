import 'package:flutter/material.dart';

class BaseButtonWidget extends MaterialButton {
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
          color: color,
          minWidth: 70,
          elevation: elevation,
        );
}
