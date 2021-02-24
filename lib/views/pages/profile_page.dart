import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/auth_controller.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/widgets/button/base_button_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_widget.dart';
import 'package:twitter_clone/views/widgets/button/outlined_button_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
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
  List<TweetModel> _userTweets;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _profileController = Provider.of<ProfileController>(context);
    _tweetController = Provider.of<TweetController>(context);
    _authController = Provider.of<AuthController>(context);

    var userId = ModalRoute.of(context).settings.arguments ??
        _authController.authUser.userId;

    await _profileController.getUserProfile(userId);
    _userTweets = await _tweetController.getUserTweets(userId);

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  OutlinedButtonWidget _editProfileButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        print("Edit profile!");
      },
      text: "Edit profile",
    );
  }

  ButtonWidget _followingButton() {
    return ButtonWidget(
      onPressed: () {
        setState(() {
          _authController.unfollow(_profileController.profile.id);
        });
      },
      text: "Following",
    );
  }

  OutlinedButtonWidget _followButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        setState(() {
          _authController.follow(_profileController.profile.id);
        });
      },
      text: "Follow",
    );
  }

  BaseButtonWidget _actionButton() {
    var loggedInUser = _authController.authUser;

    return _profileController.profile.id == loggedInUser.userId
        ? _editProfileButton()
        : loggedInUser.following.contains(_profileController.profile.id)
            ? _followingButton()
            : _followButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !_isPageReady
            ? LoadingPageWidget()
            : SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    ProfileHeaderWidget(
                      userModel: _profileController.profile,
                      actionButton: _actionButton(),
                    ),
                    TweetListWidget(tweets: _userTweets),
                  ],
                ),
              ),
      ),
    );
  }
}
