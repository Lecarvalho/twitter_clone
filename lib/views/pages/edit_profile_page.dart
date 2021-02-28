import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/multiline_textbox_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  void _onPressSave(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: ButtonActionBar(
          onPressed: () => _onPressSave(context),
          text: "Save",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: ProjectIcons.photoIcon,
              radius: 40,      
              backgroundColor: ProjectColors.grayBackground,      
            ),
            SizedBox(height: 10),
            TextboxWidget(
              textboxType: TextboxType.name,
              maxLength: AppConfig.nameMaxCharacters,
              controller: _nameController,
              hintText: "Name",
              labelText: "Name",
              showMaxLength: true,
            ),
            MultilineTextboxWidget(
              maxLength: AppConfig.bioMaxCharacters,
              hintText: "Bio",
              labelText: "Bio",
              controller: _bioController,
              withUnderline: true,
            ),
          ],
        ),
      ),
    );
  }
}
