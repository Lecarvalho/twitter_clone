import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import 'react_icon_widget.dart';

class RetweetIconWidget extends ReactIconWidget {
  RetweetIconWidget({
    @required bool isRetweeted,
    @required int retweetCount,
    @required Function() onRetweet,
  }) : super(
          isReacted: isRetweeted,
          reactCount: retweetCount,
          onTap: onRetweet,
        );

  @override
  Widget get defaultIcon => ProjectIcons.retweet;

  @override
  Widget get reactedIcon => ProjectIcons.retweetColored;

  @override
  Color get reactionColor => ProjectColors.green;
}
