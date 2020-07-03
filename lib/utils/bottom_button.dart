import 'package:flutter/material.dart';
import 'package:twitter_clone/services/google_firebase_authentication.dart';
import 'package:twitter_clone/utils/colors.dart';

class Bottom_Button extends StatelessWidget {
  Bottom_Button({Key key, @required String title, @required Function onPressed})
      : title = title,
        onPressed = onPressed,
        super(key: key);

  final String title;
  final Function onPressed;
  final Authentication _authenticationDelegate = Authentication();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0.0,
      right: 0.0,
      child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Divider(
                thickness: 1.2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButton(
                      child: Text("Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      onPressed: _authenticationDelegate.handleSignIn,
                      borderSide: BorderSide(color: AppColors.logoBlue),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                    ),
                    RaisedButton(
                      child: Text(this.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onPressed: this.onPressed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
