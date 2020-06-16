import 'package:flutter/material.dart';

import 'colors.dart';

class Theming {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppColors.lightBlue,
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
    primaryColor: AppColors.darkBlue,
  );
}
