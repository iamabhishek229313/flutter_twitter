import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/login_screen/start_screen.dart';
import 'package:twitter_clone/screens/profile_screen/profile_screen.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';


  /**
   * Below class is fo the debug purpose only .
   * 
   */
// class WrapperScreen extends StatefulWidget {
//   @override
//   _WrapperScreenState createState() => _WrapperScreenState();
// }
// // The use of wrapper class is, it listens to the Firebase User if it find that there is no user then it 
// // will trigger the StartScren and if it finds the user registered then it will return the HomePage .
// class _WrapperScreenState extends State<WrapperScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // If you want to debug Change the code below to return your desired screen .
//     return StartScreen(); // For this time being we are triggering scrren to the startscreen .
//   }
// }

/**
 * Below class is fo the proper implementation which listens to the wether the
 * user is logged in or logged out .export '
 * 
 * <A TRUE implementation of the Wrapper class .
 * 
 */

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
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context,snapshot) {
        print("Snapshot Data is : " + snapshot.data.toString());
        if(snapshot.hasData) {
          return HomeScreen();
        }
        return StartScreen();
      }
    ); // For this time being we are triggering scrren to the startscreen .
  }
}



