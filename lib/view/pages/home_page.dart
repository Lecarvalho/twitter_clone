import 'package:flutter/material.dart';
import 'package:twitter_clone/view/resources/assets.dart';
import 'package:twitter_clone/view/widgets/appbar_widget.dart';
import 'package:twitter_clone/view/widgets/profile_picture_name_horizontal_widget.dart';
import 'package:twitter_clone/view/widgets/tweet_actions_widget.dart';
import 'package:twitter_clone/view/widgets/tweet_widget.dart';

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
    TweetWidget(
      photoUrl: "assets/profile-pictures/at.jpg",
      profileName: "Leandro Carvalho",
      profileNickName: "@dev_lecarvalho",
      dateTimeTweet: DateTime(2021, 02, 14, 17, 28),
      tweetText: "Even fortnite team put theirs microservices on downtime and theirs 200 million users on hold so they can repair some big issues.",
    ),
    Text("Search"),
    Text("Notifications"),
    Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Image.asset(AssetsLogos.twitter),
        action: IconButton(
          icon: Image.asset(AssetsIcons.feature),
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
            activeIcon: Image.asset(AssetsIcons.homeSolid),
            icon: Image.asset(AssetsIcons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            activeIcon: Image.asset(AssetsIcons.searchSolid),
            icon: Image.asset(AssetsIcons.search),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            activeIcon: Image.asset(AssetsIcons.notificationSolid),
            icon: Image.asset(AssetsIcons.notification),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            activeIcon: Image.asset(AssetsIcons.profileSolid),
            icon: Image.asset(AssetsIcons.profile),
          ),
        ],
        onTap: _onNavigationTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
