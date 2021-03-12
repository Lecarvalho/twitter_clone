import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_actionbar_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/multiline_textbox_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isPageReady = false;

  late ProfileController _profileController;

  String? _avatarLocalPath;
  bool? _isNicknameAvailable;

  late bool _isProfileComplete;

  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void didChangeDependencies() async {
    _profileController = Di.instanceOf(context);

    _nameController.text = _profileController.myProfile.name;
    _nicknameController.text = _profileController.myProfile.nickname ?? "";
    _bioController.text = _profileController.myProfile.bio ?? "";

    _isProfileComplete = _profileController.myProfile.isProfileComplete;

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  void _onPressSave(BuildContext context) async {
    _closeKeyboard(context);
    if (!(_isNicknameAvailable ?? true)){
      return;
    }
    String result = await _profileController.updateProfile(
      bio: _bioController.text,
      nickname: _nicknameController.text,
      avatarLocalPath: _avatarLocalPath,
    );

    if (result != "Success") {
      PopMessage.show(result, context);
      return;
    }

    if (result == "Success") {
      Navigator.of(context).pushNamed(Routes.home);
    } else {
      PopMessage.show(result, context);
    }
  }

  void _onSetNickname() async {
    bool? isNicknameAvailable;
    if (_nicknameController.text.isNotEmpty) {
      isNicknameAvailable = await _profileController
          .isNicknameAvailable(_nicknameController.text);
      if (!isNicknameAvailable) {
        _closeKeyboard(context);
        PopMessage.show("Sorry but this nickname is not available", context);
      }
    }

    setState(() {
      _isNicknameAvailable = isNicknameAvailable;
    });
  }

  void _onPressChangePhoto() async {
    _avatarLocalPath = await _profileController.selectAvatar();
    setState(() {});
  }

  void _closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ImageProvider? get avatar {
    if (_avatarLocalPath?.isNotEmpty ?? false) {
      return FileImage(File(_avatarLocalPath!));
    }

    var avatar = _profileController.myProfile.avatar;

    if (avatar != null) {
      return NetworkImage(avatar);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: ButtonActionBarWidget(
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
                  TextboxWidget(
                    textboxType: TextboxType.nickname,
                    hintText: "Nickname",
                    labelText: "Nickname",
                    maxLength: AppConfig.nicknameMaxCharacters,
                    controller: _nicknameController,
                    keyboardEnabled: !_isProfileComplete,
                    onLostFocus: _onSetNickname,
                    showValidIcon: true,
                    isValid: _isNicknameAvailable,
                  ),
                  SizedBox(height: 20),
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
