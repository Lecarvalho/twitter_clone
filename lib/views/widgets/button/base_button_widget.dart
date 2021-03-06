import 'package:flutter/material.dart';

class BaseButtonWidget extends FlatButton {
  final Function()? onPressed;
  final String text;
  final ShapeBorder shape;
  final Color? color;
  final Color? disabledColor;
  final TextStyle textStyle;
  final double? height;

  BaseButtonWidget({
    this.onPressed,
    required this.text,
    required this.shape,
    required this.textStyle,
    this.color,
    this.disabledColor,
    this.height,
  }) : super(
          height: height,
          child: Text(text, style: textStyle),
          shape: shape,
          onPressed: onPressed,
          disabledColor: disabledColor,
          minWidth: 70,
        );
}
