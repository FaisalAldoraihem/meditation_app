import 'package:flutter/material.dart';
import 'package:meditation_app/constants/preset_timers.dart';
import 'package:meditation_app/repositorys/local_notifications.dart';
import 'package:meditation_app/src/models/meditation_exercise.dart';

/// This class holds state that initializes values required in [MeditationScreen]
class MeditationModel extends ChangeNotifier {
  bool isZenMode;
  bool playSounds;
  Duration duration;
  MeditationExercise exercise;
  List<Duration> get presets => kPresetTimers;
  LocalNotifications localNotifications;

  MeditationModel(LocalNotifications notifications) {
    isZenMode = false;
    playSounds = true;
    duration = presets[0];
    exercise = MeditationExercise(
        id: 1,
        image: 'assets/cat.jpg',
        title: 'Pursed lip breathing',
        description:
            'This simple breathing technique makes you slow down your pace of breathing by having you apply deliberate effort in each breath.',
        instructions: [
          'Relax your neck and shoulders.',
          'Keeping your mouth closed, inhale slowly through your nose for 2 counts.',
          'Pucker or purse your lips as though you were going to whistle.',
          'Exhale slowly by blowing air through your pursed lips for a count of 4.'
        ]);
    localNotifications = notifications;
  }
}
