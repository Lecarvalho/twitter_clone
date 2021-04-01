import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import 'react_icon_widget.dart';

class LikeIconWidget extends ReactIconWidget {
  LikeIconWidget({
    required bool didILike,
    required int likeCount,
    required Function() onLike,
  }) : super(
          isReacted: didILike,
          reactCount: likeCount,
          onTap: onLike,
        );

  @override
  Widget get reactedIcon => ProjectIcons.likeSolid;

  @override
  Widget get defaultIcon => ProjectIcons.like;

  @override
  Color get reactionColor => ProjectColors.red;
}
