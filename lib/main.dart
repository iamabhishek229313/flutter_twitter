import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/bloc/fake_loading/fake_loading_bloc.dart';
import 'package:twitter_clone/screens/home_screen/home_screen.dart';
import 'package:twitter_clone/screens/login_screen/login_screen.dart';
import 'package:twitter_clone/screens/login_screen/auth_screen.dart';
import 'package:twitter_clone/screens/profile_screen/profile_screen.dart';
import 'package:twitter_clone/screens/singnup_screen/signup_screen.dart';
import 'package:twitter_clone/screens/splash_screen/splash_screen.dart';
import 'package:twitter_clone/screens/wrapper_screen/wrapper_screen.dart';
import 'utils/theme.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CurrentUserBloc>(create: (BuildContext context) => CurrentUserBloc()),

        /// [Should be removed]
        RepositoryProvider<FakeLoadingBloc>(
          create: (BuildContext context) => FakeLoadingBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Twitter',
        debugShowCheckedModeBanner: false,
        theme: Theming.lightTheme,
        darkTheme: Theming.darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/wrapper': (context) => WrapperScreen(),
          '/auth': (context) => AuthScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
