
import 'package:flutter/material.dart';
import 'package:twitter_clone/utils/colors.dart';

class Large_Button extends StatelessWidget {
  const Large_Button(
      {Key key, @required String text, @required Function onPressed})
      : text = text,
        onPressed = onPressed,
        super(key: key);
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.maxFinite,
      height: 45,
      child: RaisedButton(
        color: AppColors.logoBlue,
        child: Text(
          this.text,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        textColor: Colors.white,
        onPressed: this.onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}