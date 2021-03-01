import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/my_session_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPageState createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  @override
  void didChangeDependencies() async {
    var mySessionController = Di.instanceOf<MySessionController>(context);
    var profileController = Di.instanceOf<ProfileController>(context);

    await mySessionController.tryConnect();

    if (mySessionController.amILoggedIn) {
      await profileController.getProfile(mySessionController.mySession.profileId);
      mySessionController.setMyProfile(profileController.profile);
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
