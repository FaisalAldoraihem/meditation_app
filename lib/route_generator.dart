import 'package:flutter/material.dart';
import 'package:meditation_app/src/models/route_argument.dart';
import 'package:meditation_app/src/screens/loginAndSignup/login_screen.dart';
import 'package:meditation_app/src/screens/loginAndSignup/register_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/loginScreen':
        return MaterialPageRoute(
            builder: (_) => LoginScreen(routeArgument: args as RouteArgument));

      case '/registerScreen':
        return MaterialPageRoute(
            builder: (_) =>
                RegisterScreen(routeArgument: args as RouteArgument));
    }
  }
}
