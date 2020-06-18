import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
    @required this.following,
    @required this.followers,
  }) : super(key: key);

  final int following;
  final int followers;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          color: Colors.white,
          height: 180,
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.white),
            accountName: Text(
              "Awesome Kumar",
              style: TextStyle(
                  fontFamily: 'HelveticaNeuelt',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            accountEmail: Text(
              "@awesome786689",
              style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ),
        Container(
            color: Colors.white,
            child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 16,bottom: 40)),
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
        )),
        Divider(
          color: Colors.black,
        ),
        Container(
          color: Colors.white,
          height: 400,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text("Profile"),
                    onTap: () {},
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
                    color: Colors.black,
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
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.lightbulb_outline,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(right: 250)),
              Icon(
                Icons.all_out,
                color: Colors.blue,
              )
            ],
          ),
        )
      ]),
    );
  }
}
