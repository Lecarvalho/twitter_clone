import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/views/resources/pop_message.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPageState createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  @override
  void didChangeDependencies() async {
    final authController = Di.instanceOf<AuthController>(context);
    final profileController = Di.instanceOf<ProfileController>(context);

    final response = await authController.tryAutoSigIn();

    if (response.type == ProfileStatusType.error) {
      PopMessage.show(response.message, context);
      Navigator.of(context).pushReplacementNamed(Routes.login);
      return;
    }

    if (response.type == ProfileStatusType.complete) {
      profileController.setMyProfile = authController.myProfile;
      Navigator.of(context).pushReplacementNamed(Routes.home);
      return;
    }

    if (response.type == ProfileStatusType.incomplete) {
      profileController.setMyProfile = authController.myProfile;
      Navigator.of(context).pushReplacementNamed(Routes.edit_profile);
      return;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingPageWidget(),
    );
  }
}
