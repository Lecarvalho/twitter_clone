import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/assets.dart';

import '../action_bottom_sheet_widget.dart';
import '../modal_bottom_sheet_base_widget.dart';

class ConfirmRetweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModalBottomSheetWidget(
      actions: [
        ActionBottomSheetWidget(
          icon: AssetsIcons.retweet,
          text: "Retweet",
          onPressed: () {
            print("Retweet pressed");
          },
        )
      ],
    );
  }
}
