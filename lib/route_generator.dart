import 'package:flutter/material.dart';
import 'package:meditation_app/src/models/route_argument.dart';
import 'package:meditation_app/src/screens/about_screen.dart';
import 'package:meditation_app/src/screens/loginAndSignup/login_screen.dart';
import 'package:meditation_app/src/screens/loginAndSignup/register_screen.dart';
import 'package:meditation_app/src/screens/mainScreens/selection_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/loginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/registerScreen':
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case '/MainScreen':
        return MaterialPageRoute(builder: (_) => SelectionScreen());

      case '/aboutScreen':
        return MaterialPageRoute(builder: (_) => AboutScreen());
    }
  }
}
