import 'package:flutter/material.dart';
import 'package:twitter_clone/models/profile_model.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/resources/assets.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/tweet_comment_widget.dart';

import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pagesSimulation;

  void _onNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pagesSimulation = <Widget>[
      TweetCommentWidget(
        tweetModel: TweetModel(
          dateTimeTweet: DateTime.now().subtract(Duration(hours: 3)),
          profileModel: ProfileModel(
            photoUrl: "assets/profile-pictures/marsha-ambrosius.jpg",
            profileName: "Marsha Ambrosius",
            profileNickname: "@MarshaAmbrosius",
          ),
          tweetText:
              "Just wrote a little article that summarized some my  discoveries after reading The Rust Book",
        ),
      ),
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
