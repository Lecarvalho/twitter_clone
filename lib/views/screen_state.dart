import 'package:flutter/widgets.dart';

abstract class ScreenState {
  ScreenState._();
  
  static void refreshView<T extends StatefulWidget>(State<T> view) {
    if (view.mounted) {
      // ignore: invalid_use_of_protected_member
      view.setState(() {});
    }
  }
}
