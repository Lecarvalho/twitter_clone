import 'package:flutter/material.dart';
import 'package:twitter_clone/controllers/search_controller.dart';
import 'package:twitter_clone/di/di.dart';
import 'package:twitter_clone/views/resources/colors.dart';
import 'package:twitter_clone/views/widgets/appbar_widget.dart';
import 'package:twitter_clone/views/widgets/divider_widget.dart';
import 'package:twitter_clone/views/widgets/search/search_default_banner_widget.dart';
import 'package:twitter_clone/views/widgets/search/search_result_widget.dart';
import 'package:twitter_clone/views/widgets/textbox/search_textbox_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  SearchController _searchController;

  @override
  void didChangeDependencies() {
    _searchController = Di.instanceOf<SearchController>(context);

    _handleTextSearch();
    super.didChangeDependencies();
  }

  void _handleTextSearch() {
    _searchTextController.addListener(() {
      _searchController.searchProfiles(_searchTextController.text);
      setState(() {});
    });
  }

  Widget _buildBody() {
    return _searchController.foundSomething
        ? _buildResult()
        : SearchDefaultBannerWidget();
  }

  Widget _buildResult() {
    return ListView.separated(
      itemBuilder: (_, index) => SearchResultWidget(
        profile: _searchController.profilesFound[index],
      ),
      separatorBuilder: (_, __) => DividerWidget(),
      itemCount: _searchController.profilesFound.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        title: SearchTextboxWidget(
          controller: _searchTextController,
        ),
        action: FlatButton(
          onPressed: () => Navigator.pop(context),
          textColor: ProjectColors.blueActive,
          child: Text("Cancel"),
        ),
      ),
      body: _buildBody(),
    );
  }
}
