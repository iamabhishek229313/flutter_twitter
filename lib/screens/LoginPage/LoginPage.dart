import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   actions: <Widget>[],
        // ),
        body: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              child: IconButton(
            icon: new Image.asset(
              'assets/logo/icon-480.png',
              alignment: Alignment.center,
            ),
            onPressed: () {},
            tooltip: 'just a twitter icon',
          )),
          Padding(
            padding: EdgeInsets.only(
                left: 40.0, right: 120.0, top: 200.0, bottom: 40.0),
            child: Text(
              'See what\'s happening in the world right now.',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 330,
            height: 35,
            child: RaisedButton(
              onPressed: null,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.white)),
            ),
          )
        ],
      ),
    ));
  }
}
