import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/screens/home_screen/widgets/home_drawer.dart';
import 'package:twitter_clone/screens/home_screen/widgets/navigationbar_home.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';
import 'package:twitter_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authentication _authnticationDelegate = Authentication();
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
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
              body: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  dummy_posts.length,
                  (index) => IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  child: Image(
                                      height: 60.0,
                                      image: AssetImage(dummy_posts[index]
                                          .user
                                          .user_imageUrl)),
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
                                  dummy_posts[index].user.name,
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
                                    dummy_posts[index].user.user_id,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "HelveticaNeue",
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.0),
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
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
                                      dummy_posts[index].timeStamp,
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
                              children: [
                                Text(
                                  dummy_posts[index].tweet,
                                  style: TextStyle(
                                      fontFamily: 'HelveticaNeue',
                                      color: Colors.black,
                                      fontSize: 16.0),
                                ),
                                Container(
                                  height: screenHeight * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
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
                  ),
                ),
              ),
              floatingActionButton: FAB(screenHeight: screenHeight),
              bottomNavigationBar: NavigationBar(
                icon1: Icon(Icons.home, ),
                icon2: Icon(Icons.search, ),
                icon3: Icon(Icons.notifications, ),
                icon4: Icon(Icons.message, ),
              ));
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
