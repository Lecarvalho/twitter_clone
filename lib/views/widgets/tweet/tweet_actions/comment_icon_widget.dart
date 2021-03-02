import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import 'react_icon_widget.dart';

class CommentIconWidget extends ReactIconWidget {
  CommentIconWidget({
    @required bool isCommented,
    @required int commentCount,
    @required onComment,
  }) : super(
          isReacted: isCommented,
          reactCount: commentCount,
          onTap: onComment,
        );

  @override
  Widget get defaultIcon => ProjectIcons.comment;

  @override
  Widget get reactedIcon => ProjectIcons.comment;

  @override
  Color get reactionColor => ProjectColors.gray;
}
