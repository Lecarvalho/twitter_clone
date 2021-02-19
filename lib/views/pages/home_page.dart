import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/views/resources/assets.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/tweet_create_new_widget.dart';

import 'drawer_menu.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pagesSimulation;

  void _onNavigationTapped(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed(Routes.search);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    _pagesSimulation = <Widget>[
      TweetCreateNewWidget(photoUrl: "assets/profile-pictures/at.jpg"),
      Text("Search"),
      Text("Notifications"),
      Text("Profile")
    ];

    super.initState();
  }

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
