import 'package:flutter/material.dart';
import 'package:twitter_clone/view/widgets/appbar_widget.dart';
import 'package:twitter_clone/view/widgets/outlined_button_widget.dart';

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
    OutlinedButtonWidget(
      onPressed: () {
        print("hello");
      },
      text: "Button",
    ),
    Text("Search"),
    Text("Notifications"),
    Text("Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Image.asset("assets/logos/twitter.png"),
        action: IconButton(
          icon: Image.asset("assets/icons/feature.png"),
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
            activeIcon: Image.asset("assets/icons/home-solid.png"),
            icon: Image.asset("assets/icons/home.png"),
          ),
          BottomNavigationBarItem(
            label: "Search",
            activeIcon: Image.asset("assets/icons/search-solid.png"),
            icon: Image.asset("assets/icons/search.png"),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            activeIcon: Image.asset("assets/icons/notification-solid.png"),
            icon: Image.asset("assets/icons/notification.png"),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            activeIcon: Image.asset("assets/icons/profile-solid.png"),
            icon: Image.asset("assets/icons/profile.png"),
          ),
        ],
        onTap: _onNavigationTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
