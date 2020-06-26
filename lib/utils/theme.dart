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
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      buttonColor: AppColors.logoBlue,
      textTheme: ButtonTextTheme.accent,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.logoBlue,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.logoBlue,
            width: 4.0,
          ),
        ),
      ),
      labelPadding: EdgeInsets.all(0.0),
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontSize: 12.0),
      unselectedLabelStyle: TextStyle(fontSize: 12.0),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
  );
}
