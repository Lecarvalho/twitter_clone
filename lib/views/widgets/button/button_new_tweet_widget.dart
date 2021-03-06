import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

class ButtonNewTweetWidget extends FloatingActionButton {
  final Function() onPressed;

  ButtonNewTweetWidget({required this.onPressed})
      : super(
          child: ProjectIcons.addTweet,
          onPressed: onPressed,
        );
}
