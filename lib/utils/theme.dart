import 'package:flutter/material.dart';
import 'colors.dart';

class Theming {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppColors.logoBlue,
    accentColor: AppColors.white,
    fontFamily: 'HelveticaNeue',
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: AppColors.logoBlue,
      ),
      centerTitle: true,
    ),

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      buttonColor: AppColors.logoBlue,
      textTheme: ButtonTextTheme.accent,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = lightTheme.copyWith(
    // TODO
    brightness: Brightness.dark,
  );
}
