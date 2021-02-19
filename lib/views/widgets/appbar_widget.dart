import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget(
      {@required Widget title,
      bool automaticallyImplyLeading = true,
      Widget action,
      bool centerTitle = true})
      : super(
          title: title,
          centerTitle: centerTitle,
          elevation: .33,
          actions: [action],
          brightness: Brightness.light,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
}
