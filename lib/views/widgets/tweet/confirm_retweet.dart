import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';

import '../action_bottom_sheet_widget.dart';
import '../modal_bottom_sheet_base_widget.dart';

class ConfirmRetweet extends StatelessWidget {

  final Function() onConfirmRetweet;
  ConfirmRetweet({required this.onConfirmRetweet});

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheetWidget(
      actions: [
        ActionBottomSheetWidget(
          icon: ProjectIcons.retweet,
          text: "Retweet",
          onPressed: onConfirmRetweet,
        )
      ],
    );
  }
}
