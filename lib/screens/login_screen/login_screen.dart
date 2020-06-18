import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/login_screen/widgets/more_button.dart';
import 'package:twitter_clone/utils/bottom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> choices = ['About', 'Proxy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 38),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.blue[300]),
                ),
                textColor: Colors.blue,
              ),
            ),
            More_button(choices: choices),
          ],
          elevation: 0.0,
          centerTitle: true,
          title: Container(
              child: IconButton(
            icon: new Image.asset(
              'assets/logo/icon-480.png',
              alignment: Alignment.center,
            ),
            onPressed: () {},
          ))),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 125, right: 5)),
                  ],
                ),
                Text(
                  'Log in to Twitter.',
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  decoration:
                      InputDecoration(labelText: 'Phone,email or username'),
                  autofocus: true,
                ),
                TextField(
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  autofocus: true,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 8.0),
                Align(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Bottom_Button(
            title: 'Log in',
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}

