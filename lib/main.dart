import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/signup_page.dart';
import 'utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Twitter',
      debugShowCheckedModeBanner: false,
      theme: Theming.lightTheme,
      darkTheme: Theming.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/signup': (context) => SignupPage(),
        // '/login': (context) => LoginPage(),
      },
    );
  }
}
