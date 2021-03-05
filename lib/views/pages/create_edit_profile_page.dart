import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/multiline_textbox_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class CreateEditProfilePage extends StatefulWidget {
  @override
  _CreateEditProfilePageState createState() => _CreateEditProfilePageState();
}

class _CreateEditProfilePageState extends State<CreateEditProfilePage> {
  bool _isPageReady = false;

  UserController _userController;
  ProfileController _profileController;

  String _avatarLocalPath;

  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void didChangeDependencies() async {
    _userController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    await _profileController.getMyProfile(_userController.user.id);

    if (_profileController.hasProfile) {
      _nameController.text = _profileController.profile.name;
      _bioController.text = _profileController.profile.bio;
    }
    else {
      _nameController.text = _userController.user.name;
    }

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  void _onPressSave(BuildContext context) async {
    _closeKeyboard(context);

    String result;

    if (_profileController.hasProfile) {
      result = await _profileController.updateProfile(
        _bioController.text,
        _avatarLocalPath,
      );
    } else {
      result = await _profileController.createProfile(
        avatarLocalPath: _avatarLocalPath,
        bio: _bioController.text,
      );

      if (result == "Success"){
        await _profileController.getMyProfile(_userController.user.id);
      }
    }

    if (result == "Success") {
      Navigator.of(context).pushNamed(Routes.home);
    } else {
      PopMessage.show(result, context);
    }
  }

  void _onPressChangePhoto() async {
    _avatarLocalPath = await _profileController.selectAvatar();
    setState(() {});
  }

  void _closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ImageProvider get avatar {

    if (_avatarLocalPath?.isNotEmpty ?? false){
      return FileImage(File(_avatarLocalPath));
    }

    var avatar = _profileController?.profile?.avatar;

    if (avatar?.isNotEmpty ?? false){
      return NetworkImage(avatar);
    }

    return null;      
  }

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
        child: !_isPageReady
            ? LoadingPageWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _onPressChangePhoto,
                    child: Opacity(
                      opacity: .60,
                      child: CircleAvatar(
                        child: ProjectIcons.photoIcon,
                        radius: 40,
                        backgroundColor: ProjectColors.grayBackground,
                        backgroundImage: avatar,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextboxWidget(
                    textboxType: TextboxType.name,
                    maxLength: AppConfig.nameMaxCharacters,
                    controller: _nameController,
                    keyboardEnabled: false,
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
                    autoFocus: false,
                  ),
                ],
              ),
      ),
    );
  }
}
