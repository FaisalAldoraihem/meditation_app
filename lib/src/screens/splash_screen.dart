import 'package:flutter/material.dart';
import 'package:meditation_app/config/app_config.dart' as config;

class MeditationSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            config.Colors().mainColor(1),
            config.Colors().accentColor(.8),
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/cat.jpg',
          width: 320,
          height: 320,
        ),
      ),
    );
  }
}
