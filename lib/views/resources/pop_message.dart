import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';

class PopMessage {
  PopMessage._();

  static void show(String? message, BuildContext context) {
    if (message?.isNotEmpty ?? false)
      Toast.show(
        message,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
  }
}
