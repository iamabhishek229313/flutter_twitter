import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/login_screen/login_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreeneState createState() => _StartScreeneState();
}

class _StartScreeneState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          actions: [
            
          ],
          // leading: Container(
          //   child: IconButton(
          //       icon: Icon(Icons.arrow_back),
          //       onPressed: () => Navigator.pop(context)),
          // ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 40.0, right: 120.0, top: 220.0, bottom: 40.0),
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
                        style: TextStyle(
                            color: Color.fromRGBO(70, 70, 70, 20),
                            fontSize: 14.0),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text('Log in',
                              style: TextStyle(color: Colors.blue)))
                    ],
                  ))
            ],
          ),
        ));
  }
}
