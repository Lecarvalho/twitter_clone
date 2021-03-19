import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import '../../routes.dart';

class ButtonNewTweetWidget extends FloatingActionButton {
  final BuildContext context;

  ButtonNewTweetWidget({required this.context})
      : super(
          child: ProjectIcons.addTweet,
          onPressed: () => Navigator.of(context).pushNamed(Routes.new_tweet),
        );
}
