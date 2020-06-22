import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/models/postModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_drawer.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_navigation_bar.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authentication _authnticationDelegate = Authentication();
  DatabaseAPI _dbAPIofPosts;
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    _dbAPIofPosts = DatabaseAPI('posts');
  }

  _handleBackend() async {
    user = await _authnticationDelegate.getCurrentUser();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _handleBackend(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: IconButton(
                icon: new Image.asset(
                  'assets/logo/icon-480.png',
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: _authnticationDelegate.handleSignOut)
              ],
            ),
            drawer: HomeDrawer(user: user, following: 10, followers: 1),
            body: StreamBuilder(
              stream: Firestore.instance.collection('posts').orderBy('timeStamp',descending: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children:
                      List.generate(snapshot.data?.documents?.length, (index) {
                    Post eachPost = Post.fromSnapshot(
                        snapshot.data?.documents.elementAt(index));
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: eachPost.user.user_imageUrl,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 11,
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    eachPost.user.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "HelveticaNeue",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Text(
                                      '@' + eachPost.user.email_id,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "HelveticaNeue",
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(6.0),
                                        height: 3.0,
                                        width: 3.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle),
                                      ),
                                      Text(
                                        'X',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: "HelveticaNeue",
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.0),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ))
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    eachPost.tweet,
                                    style: TextStyle(
                                        fontFamily: 'HelveticaNeue',
                                        color: Colors.black,
                                        fontSize: 16.0),
                                  ),
                                  // Will do in the new example.
                                  Container(
                                    height: screenHeight * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.indigo),
                                  ),
                                  Divider(
                                    thickness: 1.1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
            ),
            floatingActionButton: FAB(user: user, screenHeight: screenHeight),
            bottomNavigationBar: NavigationBar(
              icon1: Icon(AppIcon.home),
              icon2: Icon(AppIcon.search),
              icon3: Icon(AppIcon.notification),
              icon4: Icon(AppIcon.messageEmpty),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
