import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/bloc/fake_loading/fake_loading_bloc.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/database_models/postModel.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_drawer.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_navigation_bar.dart';
import 'package:twitter_clone/services/firebase_authentication.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';
import 'package:twitter_clone/utils/post_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authentication _authnticationDelegate = Authentication();
  User user;
  DatabaseAPI _dbAPIofPosts;
  @override
  void initState() {
    super.initState();
    _dbAPIofPosts = DatabaseAPI('posts');
  }

  _loadEngine() async {
    // user = await _authnticationDelegate.getCurrentUser();

    SharedPreferences _prefs = await SharedPreferences.getInstance();

    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection("users").document(_prefs.getString(AppConstants.userID)).get();

    user = User.fromJson(documentSnapshot.data);

    /// Register the current user in the CurrentUserBloc .
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUser(user));

    log(user.toJson().toString());

    return user;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _loadEngine(),
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
              actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: _authnticationDelegate.handleSignOut)],
            ),
            drawer: HomeDrawer(),
            body: Stack(
              children: [
                StreamBuilder(
                  stream: Firestore.instance.collection('posts').orderBy('timeStamp', descending: true).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                          constraints: BoxConstraints.expand(), child: Center(child: CircularProgressIndicator()));
                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(snapshot.data?.documents?.length, (index) {
                        Post eachPost = Post.fromSnapshot(snapshot.data?.documents.elementAt(index),
                            snapshot.data.documents.elementAt(index).documentID);
                        return PostWidget(post: eachPost);
                      }),
                    );
                  },
                ),
                BlocBuilder<FakeLoadingBloc, bool>(
                    bloc: BlocProvider.of<FakeLoadingBloc>(context),
                    builder: (context, bool toShow) {
                      return toShow
                          ? ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
                                  child: Center(
                                    child: SpinKitFadingCircle(
                                      color: AppColors.logoBlue,
                                      size: 60.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox();
                    }),
              ],
            ),
            floatingActionButton: FAB(),
            bottomNavigationBar: NavigationBar(
              icon1: Icon(AppIcon.home),
              icon2: Icon(AppIcon.search),
              icon3: Icon(AppIcon.notification),
              icon4: Icon(AppIcon.messageEmpty),
            ),
          );
        }
        return Scaffold(
            body: Container(
                color: Colors.white,
                constraints: BoxConstraints.expand(),
                child: Center(child: CircularProgressIndicator())));
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
