import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({@required Widget title, Widget action})
      : super(
          title: title,
          centerTitle: true,
          elevation: .33,
          actions: [action],
          brightness: Brightness.light,
        );
}
