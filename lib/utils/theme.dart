import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors.dart';

class Theming {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppColors.logoBlue,
    fontFamily: 'HelveticaNeue',
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.logoBlue,
      ),
    ),

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
