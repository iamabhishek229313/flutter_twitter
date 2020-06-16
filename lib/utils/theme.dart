import 'package:flutter/material.dart';

class Theming {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'HelveticaNeue',
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
  );
}
