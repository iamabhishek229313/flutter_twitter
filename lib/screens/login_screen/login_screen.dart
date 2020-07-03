import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/login_screen/widgets/more_button.dart';
import 'package:twitter_clone/services/firebase_authentication.dart';
import 'package:twitter_clone/utils/bottom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> choices = ['About', 'Proxy'];
  Authentication _authenticationDelegate = Authentication();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Log in to Twitter.',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _userIdController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    autofocus: true,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 8.0),
                  Align(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
          Bottom_Button(
            title: 'Log in',
            onPressed: () {
              _authenticationDelegate.handleSignInEmail(_userIdController.text, _passwordController.text);
            },
          ),
        ],
      ),
    );
  }
}
