import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/LoginPage/LoginPage..dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
                left: 40.0, right: 120.0, top: 250.0, bottom: 40.0),
            child: Text(
              'See what\'s happening in the world right now.',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(0, 172, 237, 10),
            ),
            width: 330,
            height: 35,
            child: RaisedButton(
              child: Text(
                'Create account',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              textColor: Colors.white,
              onPressed: null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 150)),
          Container(
            padding: EdgeInsets.only(left: 40),
              child: Row(
            children: [
              Text(
                'Have an account already?',
                style: TextStyle(color: Color.fromRGBO(70, 70, 70, 20), fontSize: 14.0),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage())
                  );
                }, 
                child: Text('Log in',
                style: TextStyle(color: Colors.blue))
                )
            ],
          ))
        ],
      ),
    ));
  }
}
