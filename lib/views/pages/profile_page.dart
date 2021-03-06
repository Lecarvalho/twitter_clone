import 'package:flutter/material.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/config/di.dart';
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
  late ProfileController _profileController;
  late TweetController _tweetController;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _profileController = Di.instanceOf<ProfileController>(context);
    _tweetController = Di.instanceOf<TweetController>(context);

    var profileId = ModalRoute.of(context)!.settings.arguments?.toString() ??
        _profileController.myProfile!.id;

    await _profileController.getProfile(profileId);
    await _tweetController.getProfileTweets(profileId);

    setState(() {
      _isPageReady = true;
    });

    super.didChangeDependencies();
  }

  OutlinedButtonWidget _editProfileButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.create_edit_profile);
      },
      text: "Edit profile",
    );
  }

  ButtonWidget _followingButton() {
    return ButtonWidget(
      onPressed: () {
        setState(() {
          _profileController.unfollow(_profileController.profile!.id);
        });
      },
      text: "Following",
    );
  }

  OutlinedButtonWidget _followButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        setState(() {
          _profileController.follow(_profileController.profile!.id);
        });
      },
      text: "Follow",
    );
  }

  BaseButtonWidget _actionButton() {
    var myProfile = _profileController.myProfile;

    return _profileController.profile!.id == myProfile!.id
        ? _editProfileButton()
        : myProfile.following.contains(_profileController.profile!.id)
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
                      profile: _profileController.profile!,
                      actionButton: _actionButton(),
                    ),
                    TweetListWidget(tweets: _tweetController.tweets),
                  ],
                ),
              ),
      ),
    );
  }
}
