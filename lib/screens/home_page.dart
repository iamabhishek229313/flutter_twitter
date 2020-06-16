import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // TODO: Change this screen entirely
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('Login'),
            onPressed: null,
          ),
          RaisedButton(
            child: Text('Sign up'),
            onPressed: () => Navigator.pushNamed(context, '/signup'),
          ),
        ],
      ),
    );
  }
}
