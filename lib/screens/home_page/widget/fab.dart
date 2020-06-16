import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 10.0,
      onPressed: () {},
      child: Image(
        height: screenHeight * 0.03,
        width: screenHeight * 0.03,
        image: AssetImage('assets/logo/t_feather.png'),
        color: Colors.white,
      ),
    );
  }
}
