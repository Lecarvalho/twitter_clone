import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/di/di.dart';
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

  MySessionController _mySessionController;
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void didChangeDependencies() async {
    _mySessionController = Di.instanceOf<MySessionController>(context);

    nameController.text = _mySessionController.mySession.myProfile.name;
    bioController.text = _mySessionController.mySession.myProfile.bio;

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  void _onPressSave(BuildContext context) async {
    _closeKeyboard(context);

    var result = await _mySessionController.updateProfile(bioController.text);
    if (result == "Success") {
      Navigator.of(context).pushNamed(Routes.home);
    } else {
      PopMessage.show(result, context);
    }
  }

  void _onPressChangePhoto() async {
    await _mySessionController.uploadAvatar(
      _mySessionController.mySession.profileId,
    );

    setState(() {});
  }

  void _closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ImageProvider get avatar {
    var avatar = _mySessionController?.mySession?.myProfile?.avatar;

    if (avatar?.isEmpty ?? true) {
      return null;
    } else
      return NetworkImage(avatar);
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
                    child: CircleAvatar(
                      child: ProjectIcons.photoIcon,
                      radius: 40,
                      backgroundColor: ProjectColors.grayBackground,
                      backgroundImage: avatar,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextboxWidget(
                    textboxType: TextboxType.name,
                    maxLength: AppConfig.nameMaxCharacters,
                    controller: nameController,
                    keyboardEnabled: false,
                    hintText: "Name",
                    labelText: "Name",
                    showMaxLength: true,
                  ),
                  MultilineTextboxWidget(
                    maxLength: AppConfig.bioMaxCharacters,
                    hintText: "Bio",
                    labelText: "Bio",
                    controller: bioController,
                    withUnderline: true,
                    autoFocus: false,
                  ),
                ],
              ),
      ),
    );
  }
}
