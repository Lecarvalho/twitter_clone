import 'package:flutter/material.dart';

class BaseButtonWidget extends FlatButton {
  final Function() onPressed;
  final String text;
  final ShapeBorder shape;
  final Color color;
  final Color disabledColor;
  final TextStyle textStyle;

  BaseButtonWidget({
    @required this.onPressed,
    @required this.text,
    @required this.shape,
    @required this.textStyle,
    this.color,
    this.disabledColor,
  }) : super(
          child: Text(text, style: textStyle),
          shape: shape,
          onPressed: onPressed,
          disabledColor: disabledColor,
        );
}
