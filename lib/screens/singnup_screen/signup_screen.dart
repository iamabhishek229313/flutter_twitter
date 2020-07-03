import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';
import 'package:twitter_clone/utils/bottom_button.dart';

class SignupScreen extends StatelessWidget {
  final Authentication _authnticationDelegate = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset('assets/logo/icon-48.png'),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 38),
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Log in',
                style: TextStyle(color: Colors.blue[300]),
              ),
              textColor: Colors.blue,
            ),
          ),
        ],
        elevation: 0,
        leading: null,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Align(
                child: Text(
                  'Create your account',
                  style:
                      Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w800, color: Colors.black),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Full name',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone number or email',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Bottom_Button(title: 'Next', onPressed: () {})
        ],
      ),
    );
  }
}
