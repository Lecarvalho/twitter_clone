import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/resources/styles.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/button/login_with_google_button_widget.dart';
import 'package:twitter_clone/views/widgets/button/outlined_button_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  late AuthController _authController;
  late ProfileController _profileController;

  @override
  void didChangeDependencies() {
    _authController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    super.didChangeDependencies();
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProjectIcons.appIcon,
        SizedBox(height: 20),
        Text(
          AppConfig.projectName,
          style: Styles.h5,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          "Flutter & Dart",
          style: Styles.subtitle1Gray,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          "App Development Course",
          style: Styles.subtitle1Gray,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onPressLogin(BuildContext context) async {
    _closeKeyboard();

    var response = await _authController.signInWithEmailAndPassword(
      _emailTextController.text,
      _passwordTextController.text,
    );

    _handleLoginResponse(response);
  }

  void _onPressCreateAccount(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.create_user);
  }

  void _onPressLoginWithGoogle() async {
    var response = await _authController.createOrSignInWithGoogle();

    _handleLoginResponse(response);
  }

  void _handleLoginResponse(MyProfileResponse response) {
    if (response.type == ProfileStatusType.error) {
      PopMessage.show(response.message, context);
      return;
    }

    if (response.type == ProfileStatusType.complete) {
      _profileController.setMyProfile = _authController.myProfile;
      Navigator.of(context).pushNamed(Routes.home);
      return;
    }

    if (response.type == ProfileStatusType.incomplete) {
      _profileController.setMyProfile = _authController.myProfile;
      Navigator.of(context).pushNamed(Routes.edit_profile);
      return;
    }
  }

  Widget _buildFields() {
    return Column(
      children: [
        TextboxWidget(
          controller: _emailTextController,
          maxLength: AppConfig.emailMaxCharacters,
          textboxType: TextboxType.email,
          hintText: "Email",
        ),
        SizedBox(height: 10),
        TextboxWidget(
          controller: _passwordTextController,
          maxLength: AppConfig.passwordMaxCharacters,
          textboxType: TextboxType.password,
          hintText: "Password",
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButtonWidget(
              onPressed: () => _onPressCreateAccount(context),
              text: "Create my account",
            ),
            ButtonWidget(
              onPressed: () => _onPressLogin(context),
              text: "Login",
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildHeader(),
                  SizedBox(height: 20),
                  _buildFields(),
                  SizedBox(height: 20),
                  Text("or", style: Styles.body2Gray),
                  SizedBox(height: 10),
                  LoginWithGoogleButtonWidget(
                    onPressed: _onPressLoginWithGoogle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
