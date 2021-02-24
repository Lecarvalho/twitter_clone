import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/user_session_controller.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPageState createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  @override
  void didChangeDependencies() async {
    var userSessionController = Provider.of<UserSessionController>(context);
    await userSessionController.tryConnect();

    if (userSessionController.isLoggedIn) {
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
