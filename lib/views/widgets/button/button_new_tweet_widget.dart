import 'package:flutter/material.dart';

class ButtonNewTweetWidget extends FloatingActionButton {
  final Function() onPressed;

  ButtonNewTweetWidget({@required this.onPressed})
      : super(
          child: Image.asset("assets/icons/add-tweet.png"),
          onPressed: onPressed,
        );
}
