import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/login_screen/start_screen.dart';
import 'package:twitter_clone/utils/bottom_button.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

// The use of wrapper class is, it listens to the Firebase User if it find that there is no user then it
// will trigger the StartScren and if it finds the user registered then it will return the HomePage .
class _WrapperScreenState extends State<WrapperScreen> {
  SharedPreferences _prefs;

  _getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPrefs(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
            constraints: BoxConstraints.expand(),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (BuildContext context, snapshot) {
              print("Snapshot Data is : " + snapshot.data.toString());
              if (snapshot.hasData) {
                if (!(_prefs.getBool(AppConstants.isRegistered) ?? false))
                  return RegistrationScreen();
                else
                  return HomeScreen();
              }
              return StartScreen(); // Contains option for Google sign in.
            });
      },
    ); // For this time being we are triggering scrren to the startscreen .
  }
}

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  DatabaseAPI _db;
  SharedPreferences _prefs;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _userName;
  TextEditingController _firstName;
  TextEditingController _lastName;
  TextEditingController _phoneNumber;
  TextEditingController _emailAddress;
  TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    _db = DatabaseAPI("users");

    _userName = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phoneNumber = TextEditingController();
    _emailAddress = TextEditingController();
    _bio = TextEditingController();
  }

  @override
  void dispose() {
    _userName.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    _emailAddress.dispose();
    _bio.dispose();
    super.dispose();
  }

  _registerUser() async {
    _prefs = await SharedPreferences.getInstance();
    String userID = _prefs.getString(AppConstants.userID);
    FirebaseUser _user;
    await FirebaseAuth.instance.currentUser().then((user) {
      _user = user;
    });

    User userData = User(
        bio: _bio.text,
        emailAddress: _user.email,
        firstName: _firstName.text,
        lastName: _lastName.text,
        phoneNumber: _phoneNumber.text,
        username: _userName.text,
        following: "0",
        followers: "0",
        postCount: "0",
        photoURL: _user.photoUrl);

    await Firestore.instance.collection("users").document(userID).setData(userData.toJson());

    _prefs.setBool(AppConstants.isRegistered, true);
    Navigator.pushReplacementNamed(context, '/wrapper');
    // Came to the Wrapper screen.
    log("User Registered");
  }

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
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(left: 38),
        //     child: FlatButton(
        //       onPressed: () {
        //         Navigator.pushNamed(context, '/login');
        //       },
        //       child: Text(
        //         'Log in',
        //         style: TextStyle(color: Colors.blue[300]),
        //       ),
        //       textColor: Colors.blue,
        //     ),
        //   ),
        // ],
        elevation: 0,
        leading: null,
      ),
      bottomNavigationBar: Bottom_Button(
          title: 'Submit',
          onPressed: () {
            if (_formkey.currentState.validate()) {
              // Register the user.
              _registerUser();
            } else {
              setState(() {
                _autoValidate = true;
              });
            }
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Align(
                  child: Text(
                    'Create your account',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                TextFormField(
                  controller: _userName,
                  autovalidate: _autoValidate,
                  validator: (value) => value.isEmpty ? "Enter username" : null,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.018,
                ),
                TextFormField(
                  controller: _firstName,
                  autovalidate: _autoValidate,
                  validator: (value) => value.isEmpty ? "Enter first name" : null,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.018,
                ),
                TextFormField(
                  controller: _lastName,
                  autovalidate: _autoValidate,
                  validator: (value) => value.isEmpty ? "Enter last name" : null,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.018,
                ),
                TextFormField(
                  controller: _phoneNumber,
                  autovalidate: _autoValidate,
                  keyboardType: TextInputType.number,
                  validator: (value) => value.isEmpty ? "Enter valid number" : null,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.018,
                // ),
                // TextFormField(
                //   controller: _emailAddress,
                //   autovalidate: _autoValidate,
                //   validator: (value) => value.isEmpty ? "Enter email address" : null,
                //   decoration: InputDecoration(
                //     labelText: 'Email address',
                //   ),
                //   style: TextStyle(color: Colors.black, fontSize: 16),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.018,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: TextFormField(
                    controller: _bio,
                    autovalidate: _autoValidate,
                    maxLines: 10,
                    maxLength: 40,
                    validator: (value) => value.isEmpty ? "Write Something about yourself" : null,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
