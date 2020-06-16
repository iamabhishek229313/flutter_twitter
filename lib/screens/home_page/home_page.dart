import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_page/widget/fab.dart';
import 'package:twitter_clone/utils/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: white,
        leading: Container(
          height: screenHeight * 0.005,
          width: screenHeight * 0.005,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {},
            color: tLogoBlue,
            iconSize: 32.0,
          )
        ],
      ),
      body: Container(
        color: white,
      ),
      floatingActionButton: FAB(screenHeight: screenHeight),
    );
  }
}

