import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import 'react_icon_widget.dart';

class HeartIconWidget extends ReactIconWidget {
  HeartIconWidget({
    @required bool isHearted,
    @required int heartCount,
    @required Function() onHeart,
  }) : super(
          isReacted: isHearted,
          reactCount: heartCount,
          onTap: onHeart,
        );

  @override
  Widget get reactedIcon => ProjectIcons.heartSolid;

  @override
  Widget get defaultIcon => ProjectIcons.heart;

  @override
  Color get reactionColor => ProjectColors.red;
}
