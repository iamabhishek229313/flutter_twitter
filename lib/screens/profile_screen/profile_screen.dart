import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';

///// Abhihsek modifications.
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final User user = BlocProvider.of<CurrentUserBloc>(context).state;
    TextStyle tabBarTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0, fontFamily: 'HelveticaNeue');

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                color: Colors.black87,
              ),
              expandedHeight: screenHeight * 0.52,
              pinned: true,
              elevation: 0.0,
              stretch: true,
              actions: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        // Biggest container to give Stack some space.
                        // Should be untouched.
                        height: (screenHeight * 0.2 + screenHeight * 0.14 / 2),
                      ),
                      Container(
                          height: screenHeight * 0.2,
                          width: screenWidth,
                          child: Image(fit: BoxFit.fill, image: AssetImage('assets/images/defaultCover.png'))),
                      Positioned(
                        top: screenHeight * 0.2 - ((screenHeight * 0.08) / 2),
                        left: screenWidth * 0.03,
                        child: Container(
                          child: AnimatedContainer(
                            duration: Duration(microseconds: 500),
                            width: screenHeight * 0.11,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: user.photoURL,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.2 + screenHeight * 0.005 - 4.0,
                        right: screenWidth * 0.03,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: OutlineButton(
                            onPressed: () {
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //   content: Text("Under Construction 💡"),
                              // ));
                            },
                            child: Center(
                              child: Text("Edit Profile"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Info, Bio, Fllowing && Followers.
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.firstName + " " + user.lastName,
                              style: TextStyle(fontSize: screenHeight * 0.031, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "@" + user.username,
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02, color: Colors.grey, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              user.bio,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              user.following + " ",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              user.followers + " ",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              )),
            ),
            // SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            //   if (index <= 100) return Text("Tweet $index");
            // }))
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              title: TabBar(controller: _tabController, isScrollable: true, tabs: [
                Container(
                  width: screenWidth * 0.18,
                  child: Tab(
                    child: Text(
                      "Tweet",
                      style: tabBarTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.38,
                  child: Tab(
                      child: Text(
                    "Tweet & Replies",
                    maxLines: 1,
                    style: tabBarTextStyle,
                  )),
                ),
                Container(
                  width: screenWidth * 0.18,
                  child: Tab(
                      child: Text(
                    "Media",
                    style: tabBarTextStyle,
                  )),
                ),
                Container(
                  width: screenWidth * 0.18,
                  child: Tab(
                      child: Text(
                    "Likes",
                    style: tabBarTextStyle,
                  )),
                ),
              ]),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Expanded(
                child: Container(
                  height: 2000.0,
                  child: TabBarView(controller: _tabController, children: [
                    // Change this below codes. 😁
                    ColorfulList(),
                    ColorfulList(),
                    ColorfulList(),
                    ColorfulList(),
                  ]),
                ),
              )
            ]))
          ],
        ),
      ),
      floatingActionButton: FAB(),
    );
  }
}

class ColorfulList extends StatelessWidget {
  ScrollController _controller = ScrollController();
  ColorfulList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        itemCount: 50,
        itemBuilder: (_, index) {
          return Container(
            height: 150.0,
            color: Colors.primaries[Random().nextInt(17)],
            child: Text(index.toString()),
          );
        });
  }
}
