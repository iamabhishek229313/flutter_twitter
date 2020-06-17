import 'package:flutter/material.dart';

import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/singnup_screen/signup_screen.dart';
import 'package:twitter_clone/screens/splash_screen/splash_screen.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: Theming.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home' : (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}
