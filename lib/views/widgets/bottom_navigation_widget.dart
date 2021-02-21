import 'package:flutter/material.dart';
import 'package:twitter_clone/views/resources/assets.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';

class BottomNavigationWidget extends BottomNavigationBar {
  final Function(int) onNavigationTapped;
  final int selectedIndex;

  BottomNavigationWidget({
    @required this.onNavigationTapped,
    @required this.selectedIndex,
  }) : super(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              activeIcon: ProjectIcons.homeSolid,
              icon: ProjectIcons.home,
            ),
            BottomNavigationBarItem(
              label: "Search",
              activeIcon: ProjectIcons.searchSolid,
              icon: ProjectIcons.search,
            ),
            BottomNavigationBarItem(
              label: "Notifications",
              activeIcon: ProjectIcons.notificationSolid,
              icon: ProjectIcons.notification,
            ),
            BottomNavigationBarItem(
              label: "Profile",
              activeIcon: ProjectIcons.profileSolid,
              icon: ProjectIcons.profile,
            ),
          ],
          onTap: onNavigationTapped,
          currentIndex: selectedIndex,
        );
}
