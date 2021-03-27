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

  late bool _amIFollowing;
  late String _myProfileId;
  late String _selectedProfileId;

  @override
  void didChangeDependencies() async {
    _profileController = Di.instanceOf<ProfileController>(context);
    _tweetController = Di.instanceOf<TweetController>(context);

    _myProfileId = _profileController.myProfile.id;
    final profileIdParam =
        ModalRoute.of(context)!.settings.arguments?.toString();

    _selectedProfileId = profileIdParam ?? _myProfileId;

    await _profileController.getProfile(_selectedProfileId);
    if (_myProfileId != _selectedProfileId) {
      _amIFollowing = await _profileController.amIFollowingProfile(
        _myProfileId,
        _selectedProfileId,
      );
    }

    _loadTweets();

    super.didChangeDependencies();
  }

  void _loadTweets() async {
    await _tweetController.getProfileTweets(
      _selectedProfileId,
      _profileController.myProfile.id,
    );

    setState(() {
      _isPageReady = true;
    });
  }

  Future<void> _onDragRefresh() async {
    _loadTweets();
  }

  OutlinedButtonWidget _editProfileButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.edit_profile);
      },
      text: "Edit profile",
    );
  }

  ButtonWidget _followingButton() {
    return ButtonWidget(
      onPressed: () {
        setState(() {
          _profileController.unfollow(_selectedProfileId);
          _amIFollowing = false;
        });
      },
      text: "Following",
    );
  }

  OutlinedButtonWidget _followButton() {
    return OutlinedButtonWidget(
      onPressed: () {
        setState(() {
          _profileController.follow(_selectedProfileId);
          _amIFollowing = true;
        });
      },
      text: "Follow",
    );
  }

  BaseButtonWidget _actionButton() {
    if (_selectedProfileId == _myProfileId) {
      return _editProfileButton();
    }

    if (_amIFollowing) {
      return _followingButton();
    }

    return _followButton();
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
                    TweetListWidget(
                      tweets: _tweetController.tweets,
                      onDragRefresh: _onDragRefresh,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
