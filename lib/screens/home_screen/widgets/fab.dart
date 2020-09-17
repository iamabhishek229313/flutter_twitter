import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/writing_panel.dart';
import 'package:twitter_clone/utils/colors.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.logoBlue,
      elevation: 10.0,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WritingPanel()));
      },
      child: Image.asset(
        'assets/images/t_feather_plus.png',
        fit: BoxFit.contain,
        height: 35.0,
      ),
    );
  }
}
