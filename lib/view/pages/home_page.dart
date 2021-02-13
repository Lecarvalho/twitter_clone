import 'package:flutter/material.dart';
import 'package:twitter_clone/view/project_assets.dart';
import 'package:twitter_clone/view/widgets/appbar_widget.dart';
import 'package:twitter_clone/view/widgets/tweet_actions_widget.dart';

import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pagesSimulation = <Widget>[
    TweetActionsWidget(
      totalComments: 46,
      totalRetweets: 18,
      totalLikes: 363,
    ),
    Text("Search"),
    Text("Notifications"),
    Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Image.asset(LogoAssets.twitter),
        action: IconButton(
          icon: Image.asset(IconAssets.feature),
          onPressed: null,
        ),
      ),
      drawer: Drawer(
        child: DrawerMenu(),
      ),
      body: Center(child: _pagesSimulation.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            activeIcon: Image.asset(IconAssets.homeSolid),
            icon: Image.asset(IconAssets.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            activeIcon: Image.asset(IconAssets.searchSolid),
            icon: Image.asset(IconAssets.search),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            activeIcon: Image.asset(IconAssets.notificationSolid),
            icon: Image.asset(IconAssets.notification),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            activeIcon: Image.asset(IconAssets.profileSolid),
            icon: Image.asset(IconAssets.profile),
          ),
        ],
        onTap: _onNavigationTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
