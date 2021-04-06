import 'package:flutter/material.dart';
import 'package:twitter_clone/config/app_debug.dart';
import 'package:twitter_clone/controllers/feed_controller.dart';
import 'package:twitter_clone/views/routes.dart';
import 'package:twitter_clone/controllers/profile_controller.dart';
import 'package:twitter_clone/config/di.dart';
import 'package:twitter_clone/views/pages/notifications_page.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/resources/project_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/bottom_navigation_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_new_tweet_widget.dart';
import 'package:twitter_clone/views/widgets/button/tap_to_update_button_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/loading_page_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_list_widget.dart';

import '../screen_state.dart';
import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late FeedController _feedController;
  late ProfileController _profileController;

  bool _isPageReady = false;
  bool _showUpdateFeedButton = false;

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

    _selectedIndex = index;
    ScreenState.refreshView(this);
  }

  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void didChangeDependencies() async {
    _feedController = Di.instanceOf(context);

    _profileController = Di.instanceOf(context);

    _loadMyFeed();

    print("didChangeDependencies");

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    print("didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  void _loadMyFeed() async {
    _feedController.listenFeed(
      _profileController.myProfile.id,
      (asksToRefresh) {
        if (asksToRefresh) {
          _showUpdateFeedButton = true;
        } else {
          _showUpdateFeedButton = false;
          _feedController.refreshShownTweets();
        }
        _isPageReady = true;
        ScreenState.refreshView(this);
      },
    );

    _isPageReady = true;
    ScreenState.refreshView(this);
  }

  Set<Widget> get _pagesNavigation => {
        !_isPageReady
            ? LoadingPageWidget()
            : Stack(children: [
                TweetListWidget(tweets: _feedController.tweets),
                Visibility(
                  visible: _showUpdateFeedButton,
                  child: TapToUpdateButtonWidget(
                    onPressed: _onRefreshFeed,
                  ),
                ),
              ]),
        Text("Search"),
        NotificationsPage(),
        Text("Profile")
      };

  Future<void> _onRefreshFeed() async {
    _feedController.refreshShownTweets();
    _showUpdateFeedButton = false;
    ScreenState.refreshView(this);
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
