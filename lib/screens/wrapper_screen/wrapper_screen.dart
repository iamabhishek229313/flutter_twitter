import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/login_screen/start_screen.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}
// The use of wrapper class is, it listens to the Firebase User if it find that there is no user then it 
// will trigger the StartScren and if it finds the user registered then it will return the HomePage .
class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    // If you want to debug Change the code below to return your desired screen .
    return StartScreen(); // For this time being we are triggering scrren to the startscreen .
  }
}
