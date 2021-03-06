import 'package:flutter/material.dart';
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
  late List<Widget> _pagesSimulation;

  late TweetController _tweetController;
  late ProfileController _profileController;

  bool _isPageReady = false;

  void _onNavigationTapped(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed(Routes.search);
    } else if (index == 3) {
      Navigator.of(context).pushNamed(Routes.profile);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void didChangeDependencies() async {
    _tweetController = Di.instanceOf(context);
    _profileController = Di.instanceOf(context);

    await _tweetController.getTweets(_profileController.myProfile!.id);

    setState(() {
      _isPageReady = true;
    });

    _pagesSimulation = <Widget>[
      TweetListWidget(tweets: _tweetController.tweets),
      Text("Search"),
      NotificationsPage(),
      Text("Profile"),
    ];

    super.didChangeDependencies();
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
      body: !_isPageReady
          ? LoadingPageWidget()
          : Center(child: _pagesSimulation.elementAt(_selectedIndex)),
      floatingActionButton: ButtonNewTweetWidget(
        onPressed: () => Navigator.of(context).pushNamed(Routes.new_tweet),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onNavigationTapped: _onNavigationTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
