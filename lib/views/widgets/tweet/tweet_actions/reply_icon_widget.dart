import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import 'react_icon_widget.dart';

class ReplyIconWidget extends ReactIconWidget {
  ReplyIconWidget({
    required bool isReplyed,
    required int repliesCount,
    required onReply,
  }) : super(
          isReacted: isReplyed,
          reactCount: repliesCount,
          onTap: onReply,
        );

  @override
  Widget get defaultIcon => ProjectIcons.reply;

  @override
  Widget get reactedIcon => ProjectIcons.reply;

  @override
  Color get reactionColor => ProjectColors.gray;
}
