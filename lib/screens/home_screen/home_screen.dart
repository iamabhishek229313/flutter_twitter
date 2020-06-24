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
// import 'package:intl/intl.dart';
import 'package:twitter_clone/utils/post_widget.dart';

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
              stream: Firestore.instance
                  .collection('posts')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children:
                      List.generate(snapshot.data?.documents?.length, (index) {
                    Post eachPost = Post.fromSnapshot(
                        snapshot.data?.documents.elementAt(index));
                    return PostWidget(post: eachPost);
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

// String readTimestamp(int timestamp) {
//   var now = DateTime.now();
//   var format = new DateFormat('HH:mm a');
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   var diff = now.difference(date);
//   var time = '';

//   if (diff.inSeconds <= 0 ||
//       diff.inSeconds > 0 && diff.inMinutes == 0 ||
//       diff.inMinutes > 0 && diff.inHours == 0 ||
//       diff.inHours > 0 && diff.inDays == 0) {
//     time = format.format(date);
//   } else if (diff.inDays > 0 && diff.inDays < 7) {
//     if (diff.inDays == 1) {
//       time = diff.inDays.toString() + ' DAY AGO';
//     } else {
//       time = diff.inDays.toString() + ' DAYS AGO';
//     }
//   } else {
//     if (diff.inDays == 7) {
//       time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
//     } else {
//       time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
//     }
//   }

//   return time;
// }
