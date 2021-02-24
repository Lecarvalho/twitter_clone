import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/views/widgets/button/outlined_button_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_list_widget.dart';
import 'package:twitter_clone/views/widgets/user/profile_header_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _profileController;
  TweetController _tweetController;
  AuthController _authController;
  String _userId;

  @override
  void didChangeDependencies() {
    _profileController = Provider.of<ProfileController>(context);
    _tweetController = Provider.of<TweetController>(context);
    _authController = Provider.of<AuthController>(context);
    
    _userId = ModalRoute.of(context).settings.arguments ?? _authController.userSession.id;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              FutureBuilder<UserModel>(
                future: _profileController.getUserProfile(_userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ProfileHeaderWidget(
                      userModel: snapshot.data,
                      actionButton: OutlinedButtonWidget(
                        onPressed: () {
                          print("Edit profile!");
                        },
                        text: "Edit profile",
                      ),
                    );
                  }
                  return Container();
                },
              ),
              FutureBuilder<List<TweetModel>>(
                future: _tweetController.getUserTweets(_userId),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.done){
                    return TweetListWidget(tweets: snapshot.data);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
