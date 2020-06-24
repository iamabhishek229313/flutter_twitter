import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/login_screen/login_screen.dart';
import 'package:twitter_clone/screens/login_screen/start_screen.dart';
import 'package:twitter_clone/screens/profile_screen/profile_screen.dart';
import 'package:twitter_clone/screens/singnup_screen/signup_screen.dart';
import 'package:twitter_clone/screens/splash_screen/splash_screen.dart';
import 'package:twitter_clone/screens/wrapper_screen/wrapper_screen.dart';
import 'utils/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twitter',
      debugShowCheckedModeBanner: false,
      theme: Theming.lightTheme,
      darkTheme: Theming.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/wrapper': (context) => WrapperScreen(),
        '/start':(context) => StartScreen(),
        '/login' : (context) => LoginScreen() ,
        '/signup': (context) => SignupScreen(),
        '/home' : (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen()
      },
    );
  }
}
