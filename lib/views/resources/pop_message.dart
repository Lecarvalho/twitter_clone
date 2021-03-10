import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PopMessage {
  PopMessage._();

  static void show(String message, BuildContext context) {
    if (message.isNotEmpty)
      Toast.show(
        message,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
  }
}
