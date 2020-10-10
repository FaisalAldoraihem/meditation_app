import 'package:flutter/material.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/src/screens/mainScreens/meditation_mode.dart';
import 'package:provider/provider.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MeditationMode(
          Provider.of<MeditationModel>(context, listen: false).duration,
          zenMode:
              Provider.of<MeditationModel>(context, listen: false).isZenMode,
          playSounds:
              Provider.of<MeditationModel>(context, listen: false).playSounds,
        ),
      ),
    );
  }
}
