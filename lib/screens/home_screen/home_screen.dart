import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/models/postModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_drawer.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_navigation_bar.dart';
import 'package:twitter_clone/screens/home_screen/widgets/view_image_screen.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';
// import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                    return Column(
                      children: [
                        Row(
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: eachPost.user.user_imageUrl,
                                          fit: BoxFit.fitHeight,
                                        ),
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
                                          timeago.format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  eachPost.timeStamp)),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "HelveticaNeue",
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.0),
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
                                    (eachPost.attached_image == null)
                                        ? Container()
                                        : Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.27,
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[200],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => ViewImageScreen(
                                                    imageUrl: eachPost.attached_image,
                                                  )
                                                ));
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                    placeholder:
                                                        kTransparentImage,
                                                    image:
                                                        eachPost.attached_image,
                                                    fit: BoxFit.fitHeight,
                                                  )),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Icon(
                                                AppIcon.reply,
                                                size: 19.0,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 2.0,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text("90",
                                                      style: TextStyle(
                                                          fontSize: 16.0)))
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            AppIcon.retweet,
                                            size: 19.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              Icon(
                                                AppIcon.heartEmpty,
                                                size: 19.0,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 2.0,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text("22",
                                                      style: TextStyle(
                                                          fontSize: 16.0)))
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Icon(
                                              Icons.share,
                                              size: 16.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 0.4,
                          height: 20.0,
                          color: Colors.blueGrey[200],
                        ),
                      ],
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
