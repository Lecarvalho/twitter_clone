import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/user_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
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

    await userController.tryAutoSigIn();

    if (userController.amILoggedIn) {
      await profileController.getMyProfile(userController.user!.id);
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
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
