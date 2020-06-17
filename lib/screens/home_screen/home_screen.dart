import 'package:flutter/material.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: AppColors.white,
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
            color: AppColors.logoBlue,
            iconSize: 32.0,
          )
        ],
      ),
      body: Container(
        color: AppColors.white,
      ),
      floatingActionButton: FAB(screenHeight: screenHeight),
    );
  }
}

