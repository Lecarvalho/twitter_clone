import 'package:flutter/material.dart';

class ButtonNewTweetWidget extends FloatingActionButton {

  ButtonNewTweetWidget() : super(
    child: Image.asset("assets/icons/add-tweet.png"),
    onPressed: () => print("add tweet"),
  );
}