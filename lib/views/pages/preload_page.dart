import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
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
    var userController = Di.instanceOf<UserController>(context);
    var profileController = Di.instanceOf<ProfileController>(context);

    var response = await userController.tryAutoSigIn();

    if (response.type == ProfileStatusType.error) {
      PopMessage.show(response.message, context);
      Navigator.of(context).pushReplacementNamed(Routes.login);
      return;
    }

    if (response.type == ProfileStatusType.complete) {
      profileController.setMyProfile = userController.myProfile;
      Navigator.of(context).pushReplacementNamed(Routes.home);
      return;
    }

    if (response.type == ProfileStatusType.incomplete) {
      profileController.setMyProfile = userController.myProfile;
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
