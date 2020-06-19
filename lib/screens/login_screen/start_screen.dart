import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/login_screen/login_screen.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/large_buttons.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreeneState createState() => _StartScreeneState();
}

class _StartScreeneState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
              child: IconButton(
            icon: new Image.asset(
              'assets/logo/icon-480.png',
              alignment: Alignment.center,
            ),
            onPressed: () {},
            tooltip: 'just a twitter icon',
          )),
          actions: [],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Text(
                  'See what\'s \nhappening in the world\nright now.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Large_Button(
                  text: "Create account",
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/signup');
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Have an account already?',
                      style: TextStyle(
                          color: Color.fromRGBO(70, 70, 70, 20),
                          fontSize: 14.0),
                    ),
                    SizedBox(width: 8.0),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Log in',
                            style: TextStyle(color: Colors.blue)))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ],
            ),
          ),
        ));
  }
}

