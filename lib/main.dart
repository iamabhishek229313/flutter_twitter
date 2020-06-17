import 'package:flutter/material.dart';
import './screens/LoginPage/StartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twitter',
      debugShowCheckedModeBanner: false,
      home: StartPage()
    );
  }
}


