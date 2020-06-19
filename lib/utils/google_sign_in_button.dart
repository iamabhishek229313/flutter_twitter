import 'package:flutter/material.dart';

class Google_sign_in_button extends StatelessWidget {
  const Google_sign_in_button({
    Key key,
    @required Function onPressed
  }) : onPressed = onPressed , super(key: key);
  final Function onPressed ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.maxFinite,
      height: 45,
      child: RaisedButton(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage('assets/logo/google_logo.png'),
              height: 25.0,
              width: 25.0,
            ),
            Text(
              "GOOGLE SIGN IN",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ],
        ),
        textColor: Colors.white,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
