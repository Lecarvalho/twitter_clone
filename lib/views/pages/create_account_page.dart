import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  MySessionController _mySessionController;
  ProfileController _profileController;

  @override
  void didChangeDependencies() {
    _mySessionController = Di.instanceOf<MySessionController>(context);
    _profileController = Di.instanceOf<ProfileController>(context);
    super.didChangeDependencies();
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onPressNext(BuildContext context) async {
    _closeKeyboard();

    var result = await _mySessionController.createUserProfile(
      email: _emailController.text,
      name: _nameController.text,
      nickname: _nicknameController.text,
      password: _passwordController.text,
    );

    if (result.success) {
      var result = await _mySessionController.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (_mySessionController.amILoggedIn) {
        await _profileController.getProfile(_mySessionController.mySession.profileId);
        _mySessionController.setMyProfile(_profileController.profile);
        
        Navigator.of(context).pushReplacementNamed(Routes.edit_profile);
      } else {
        PopMessage.show(result, context);
      }
    } else {
      PopMessage.show(result.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: ProjectLogos.twitter,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  TextboxWidget(
                    textboxType: TextboxType.name,
                    hintText: "Name",
                    showMaxLength: true,
                    maxLength: AppConfig.nameMaxCharacters,
                    controller: _nameController,
                  ),
                  SizedBox(height: 20),
                  TextboxWidget(
                    textboxType: TextboxType.email,
                    hintText: "Email address",
                    maxLength: AppConfig.emailMaxCharacters,
                    controller: _emailController,
                  ),
                  SizedBox(height: 20),
                  TextboxWidget(
                    textboxType: TextboxType.nickname,
                    hintText: "Nickname",
                    maxLength: AppConfig.nicknameMaxCharacters,
                    controller: _nicknameController,
                  ),
                  SizedBox(height: 20),
                  TextboxWidget(
                    textboxType: TextboxType.password,
                    hintText: "Password",
                    maxLength: AppConfig.passwordMaxCharacters,
                    controller: _passwordController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            DividerWidget(),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: ButtonWidget(
                onPressed: () => _onPressNext(context),
                text: "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
