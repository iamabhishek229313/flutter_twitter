import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/utils/colors.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.logoBlue,
      elevation: 10.0,
      onPressed: () {},
      child: Image.asset('assets/images/t_feather_plus.png',fit: BoxFit.contain,height: 35.0,),
    );
  }
}
