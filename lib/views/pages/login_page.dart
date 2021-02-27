import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/user_session_controller.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';
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
  UserSessionController _userSessionController;

  @override
  void didChangeDependencies() {
    _userSessionController = Provider.of<UserSessionController>(context);
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

  void _signInWithEmailAndPassword(BuildContext context) async {
    var result = await _userSessionController.signInWithEmailPassword(
      _emailTextController.text,
      _passwordTextController.text,
    );

    if (result == "Success") {
      Navigator.of(context).pushNamed(Routes.home);
    } else {
      print("Error: $result");
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
              onPressed: () {
                print("create my account");
              },
              text: "Create my account",
            ),
            ButtonWidget(
              onPressed: () => _signInWithEmailAndPassword(context),
              text: "Login",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginWithGoogle() {
    return LoginWithGoogleButtonWidget(
      onPressed: () async {
        await _userSessionController.signInWithGoogle();
        if (_userSessionController.isLoggedIn){
          Navigator.of(context).pushNamed(Routes.home);
        }
      },
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
                  _buildLoginWithGoogle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
