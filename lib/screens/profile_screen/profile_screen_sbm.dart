import 'package:flutter/material.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/models/userModel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  // DatabaseAPI _dbAPIofPosts;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    // _dbAPIofPosts = DatabaseAPI('posts');
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: Container(),
              
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Tweets'),
                  Tab(text: 'Tweets & replies'),
                  Tab(text: 'Media'),
                  Tab(text: 'Likes')
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
