import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
    @required this.user,
    @required this.following,
    @required this.followers,
  }) : super(key: key);

  final FirebaseUser user;
  final int following;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                user.displayName,
                style: TextStyle(
                    fontFamily: 'HelveticaNeuelt',
                    color: Colors.black,
                    fontSize: 17,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800),
              ),
              accountEmail: Text(
                user.email,
                style: TextStyle(
                    fontFamily: 'HelveticaNeue',
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: user.photoUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '$following Following',
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: Colors.grey[10],
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '  $followers Followers',
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue',
                      color: Colors.grey[10],
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(AppIcon.profile),
                    title: Text("Profile"),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/profile',
                        arguments: User(
                          name: user.displayName,
                          email_id: user.email,
                          user_imageUrl: user.photoUrl,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text("Lists"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text("Topics"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text("Bookmarks"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.monochrome_photos),
                    title: Text("Moments"),
                    onTap: () {},
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text("Settings and privacy"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Moments"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Help Center"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  AppIcon.bulb,
                  color: Colors.blue,
                  size: 30.0,
                ),
                Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.blue,
                  size: 30.0,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
