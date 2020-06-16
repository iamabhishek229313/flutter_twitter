import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_page/home_page.dart';
import 'package:twitter_clone/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1200),(){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tLogoBlue,
      body: Center(
          child: Image.asset(
        'assets/logo/t_white_logo.png',
        height: 100.0,
        width: 100.0,
      )),
    );
  }
}
