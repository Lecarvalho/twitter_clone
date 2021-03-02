import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';

import 'action_bottom_sheet_widget.dart';
import 'button/button_expanded_widget.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  final List<ActionBottomSheetWidget> actions;

  ModalBottomSheetWidget({@required this.actions});

  Widget _buildTopLine() {
    return Container(
      width: 40,
      height: 4,
      color: ProjectColors.grayBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 5),
        _buildTopLine(),
        ...actions,
        SizedBox(height: 10),
        ButtonExpandedWidget(
          onPressed: () => Navigator.pop(context),
          text: "Cancel",
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
