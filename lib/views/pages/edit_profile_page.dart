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
  final _viewModel = EditProfileViewModel();

  @override
  void didChangeDependencies() async {
    await _viewModel.loadPage(context);

    setState(() {
      _viewModel.isPageReady = true;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: ButtonActionBar(
          onPressed: () => _viewModel.onPressSave(context),
          text: "Save",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: !_viewModel.isPageReady
            ? LoadingPageWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _viewModel.onPressChangePhoto,
                    child: CircleAvatar(
                      child: ProjectIcons.photoIcon,
                      radius: 40,
                      backgroundColor: ProjectColors.grayBackground,
                      backgroundImage: _viewModel.avatar,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextboxWidget(
                    textboxType: TextboxType.name,
                    maxLength: AppConfig.nameMaxCharacters,
                    controller: _viewModel.nameController,
                    keyboardEnabled: false,
                    hintText: "Name",
                    labelText: "Name",
                    showMaxLength: true,
                  ),
                  MultilineTextboxWidget(
                    maxLength: AppConfig.bioMaxCharacters,
                    hintText: "Bio",
                    labelText: "Bio",
                    controller: _viewModel.bioController,
                    withUnderline: true,
                  ),
                ],
              ),
      ),
    );
  }
}

class EditProfileViewModel {
  String _avatar;
  bool isPageReady = false;

  MySessionController _mySessionController;
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  Future<void> loadPage(BuildContext context) async {
    _mySessionController = Di.instanceOf<MySessionController>(context);

    _fill();
  }

  void onPressSave(BuildContext context) async {
    _closeKeyboard(context);
    
    var result = await _mySessionController.updateProfile(bioController.text);
    if (result == "Success") {
      Navigator.of(context).pushNamed(Routes.home);
    } else {
      PopMessage.show(result, context);
    }
  }

  void onPressChangePhoto() {
    _mySessionController.uploadAvatar(
      _mySessionController.mySession.profileId,
      "selectedImagePath",
    );
  }

  void _fill() {
    nameController.text = _mySessionController.mySession.myProfile.name;
    bioController.text = _mySessionController.mySession.myProfile.bio;
    _avatar = _mySessionController.mySession.myProfile.avatar;
  }

  void _closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ImageProvider get avatar {
    if (_avatar?.isEmpty ?? true) {
      return null;
    } else
      return NetworkImage(_avatar);
  }
}
