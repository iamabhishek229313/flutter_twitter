import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/utils/constant_icons.dart';
import 'package:twitter_clone/utils/some_const.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = BlocProvider.of<CurrentUserBloc>(context).state;
    return Drawer(
      elevation: 10.0,
      child: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          GestureDetector(
            onTap: () {
              print("Go to profile screen invoked.");
              Navigator.pushNamed(context, '/profile');
            },
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                accountName: Text(
                  user.firstName + " " + user.lastName,
                  style: TextStyle(
                      fontFamily: 'HelveticaNeuelt',
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w800),
                ),
                accountEmail: Text(
                  user.emailAddress,
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: user.photoURL ?? custom_discord,
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  '${user.following} Following',
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue', color: Colors.grey[10], fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  '  ${user.followers} Followers',
                  style: TextStyle(
                      fontFamily: 'HelveticaNeue', color: Colors.grey[10], fontSize: 14, fontWeight: FontWeight.bold),
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
