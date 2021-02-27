import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/views/pages/notifications_page.dart';
import 'package:twitter_clone/views/resources/project_logos.dart';
import 'package:twitter_clone/views/resources/projects_icons.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/bottom_navigation_widget.dart';
import 'package:twitter_clone/views/widgets/button/button_new_tweet_widget.dart';
import 'package:twitter_clone/views/widgets/tweet/tweet_list_widget.dart';

import 'drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pagesSimulation;
  TweetController _tweetController;

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
  void didChangeDependencies() {
    _tweetController = Provider.of<TweetController>(context);

    _pagesSimulation = <Widget>[
      FutureBuilder<List<TweetModel>>(
        future: _tweetController.getTweets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TweetListWidget(tweets: snapshot.data);
          }
          return Container();
        },
      ),
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
      drawer: DrawerMenu(context: context),
      body: Center(child: _pagesSimulation.elementAt(_selectedIndex)),
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
