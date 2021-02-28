import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/config/app_config.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
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

  ProfileController _profileController;

  @override
  void didChangeDependencies() {
    _profileController = Provider.of<ProfileController>(context);
    super.didChangeDependencies();
  }

  void _closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _onPressNext(BuildContext context) async {
    _closeKeyboard();
    
    var result = await _profileController.createUserProfile(
      emailAddress: _emailController.text,
      name: _nameController.text,
      nickname: _nicknameController.text,
      password: _passwordController.text,
    );

    PopMessage.show(result.message, context);

    if (result.success)
      Navigator.of(context).pushReplacementNamed(Routes.edit_profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: ProjectLogos.twitter,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height - 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextboxWidget(
                      textboxType: TextboxType.name,
                      hintText: "Name",
                      showMaxLength: true,
                      maxLength: AppConfig.nameMaxCharacters,
                      controller: _nameController,
                    ),
                    TextboxWidget(
                      textboxType: TextboxType.email,
                      hintText: "Email address",
                      maxLength: AppConfig.emailMaxCharacters,
                      controller: _emailController,
                    ),
                    TextboxWidget(
                      textboxType: TextboxType.nickname,
                      hintText: "Nickname",
                      maxLength: AppConfig.nicknameMaxCharacters,
                      controller: _nicknameController,
                    ),
                    TextboxWidget(
                      textboxType: TextboxType.password,
                      hintText: "Password",
                      maxLength: AppConfig.passwordMaxCharacters,
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    );
  }
}
