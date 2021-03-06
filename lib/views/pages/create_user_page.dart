import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/textbox_widget.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserController _userController;

  @override
  void didChangeDependencies() {
    _userController = Di.instanceOf(context);
    super.didChangeDependencies();
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onPressNext(BuildContext context) async {
    _closeKeyboard();

    var result = await _userController.createUserWithEmailPassword(
      email: _emailController.text,
      name: _nameController.text,
      nickname: _nicknameController.text,
      password: _passwordController.text,
    );

    if (result == "Success") {
      var result = await _userController.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (_userController.amILoggedIn) {
        PopMessage.show("We are almost done...", context);

        Navigator.of(context).pushReplacementNamed(Routes.create_edit_profile);
      } else {
        PopMessage.show(result, context);
      }
    } else {
      PopMessage.show(result, context);
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
