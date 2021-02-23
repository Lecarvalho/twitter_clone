import 'package:flutter/material.dart';
import 'package:twitter_clone/config/routes.dart';
import 'package:twitter_clone/controllers/tweet_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/services/mock/tweets_service_mock.dart';
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
    var tweetController = TweetController(service: TweetsServiceMock());

    _pagesSimulation = <Widget>[
      FutureBuilder<List<TweetModel>>(
        future: tweetController.getTweets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TweetListWidget(tweets: snapshot.data);
          }
          return Container();
        },
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
        title: ProjectLogos.twitter,
        action: IconButton(
          icon: ProjectIcons.feature,
          onPressed: null,
        ),
      ),
      drawer: DrawerMenu(),
      body: Center(child: _pagesSimulation.elementAt(_selectedIndex)),
      floatingActionButton: ButtonNewTweetWidget(
        onPressed: () => print("add tweet!"),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        onNavigationTapped: _onNavigationTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
