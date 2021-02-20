import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/search_textbox_widget.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        title: SearchTextboxWidget(),
        action: FlatButton(
          onPressed: () => Navigator.pop(context),
          textColor: ProjectColors.blueActive,
          child: Text("Cancel"),
        ),
      ),
    );
  }
}
