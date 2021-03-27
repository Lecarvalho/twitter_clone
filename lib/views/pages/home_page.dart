import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_debug.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/pages/notifications_page.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/bottom_navigation_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_new_tweet_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_list_widget.dart';

import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late TweetController _tweetController;
  late ProfileController _profileController;

  bool _isPageReady = false;

  void _onNavigationTapped(int index) {
    switch (index) {
      case 0: //feed
        _loadMyFeed();
        break;
      case 1: //search
        Navigator.of(context).pushNamed(Routes.search);
        return;
      case 3: //profile
        Navigator.of(context).pushNamed(Routes.profile);
        return;
      case 2: //notifications
      default:
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() async {
    _tweetController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    _loadMyFeed();

    super.didChangeDependencies();
  }

  void _loadMyFeed() async {
    await _tweetController.getTweets(_profileController.myProfile.id);

    if (_tweetController.tweets == null) {
      Navigator.of(context).pushNamed(Routes.search);
      return;
    }

    setState(() {
      _isPageReady = true;
    });
  }

  Set<Widget> get _pagesNavigation => {
        !_isPageReady
            ? LoadingPageWidget()
            : TweetListWidget(
                tweets: _tweetController.tweets,
                onDragRefresh: _onDragRefresh,
              ),
        Text("Search"),
        NotificationsPage(),
        Text("Profile")
      };

  Future<void> _onDragRefresh() async {
    _loadMyFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: ProjectLogos.twitter,
        action: IconButton(
          icon: ProjectIcons.feature,
          onPressed: null,
        ),
      ),
      drawer: DrawerMenu(),
      body: _pagesNavigation.elementAt(_selectedIndex),
      floatingActionButton: ButtonNewTweetWidget(context: context),
      bottomNavigationBar: BottomNavigationWidget(
        onNavigationTapped: _onNavigationTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
