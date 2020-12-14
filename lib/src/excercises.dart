import 'package:meditation_app/src/models/meditation_exercise.dart';

class Exercises {
  static final List exercises = [
    MeditationExercise(
        id: 1,
        image: 'assets/pursed lip breathing.jpg',
        title: 'Pursed lip breathing',
        description:
            'This simple breathing technique makes you slow down your pace of breathing by having you apply deliberate effort in each breath.',
        instructions: [
          'Relax your neck and shoulders.',
          'Keeping your mouth closed, inhale slowly through your nose for 2 counts.',
          'Pucker or purse your lips as though you were going to whistle.',
          'Exhale slowly by blowing air through your pursed lips for a count of 4.'
        ]),
    MeditationExercise(
        id: 2,
        image: 'assets/breath focus technique.png',
        title: 'Breath focus technique',
        description:
            'This deep breathing technique uses imagery or focus words and phrases.',
        instructions: [
          'Sit or lie down in a comfortable place.',
          'Bring your awareness to your breaths without trying to change how you’re breathing.',
          'Alternate between normal and deep breaths a few times. Notice any differences between normal breathing and deep breathing. Notice how your abdomen expands with deep inhalations.',
          'Note how shallow breathing feels compared to deep breathing.',
          'Practice your deep breathing for a few minutes.',
          'Place one hand below your belly button, keeping your belly relaxed, and notice how it rises with each inhale and falls with each exhale.',
          'Let out a loud sigh with each exhale.',
          'Begin the practice of breath focus by combining this deep breathing with imagery and a focus word or phrase that will support relaxation.',
          'You can imagine that the air you inhale brings waves of peace and calm throughout your body. Mentally say, “Inhaling peace and calm".',
          'Imagine that the air you exhale washes away tension and anxiety. You can say to yourself, “Exhaling tension and anxiety.”'
        ]),
    MeditationExercise(
        id: 3,
        image: 'assets/Equal breathing.jpg',
        title: 'Equal breathing',
        description:
            'Equal breathing is known as sama vritti in Sanskrit. This breathing technique focuses on making your inhales and exhales the same length.',
        instructions: [
          'Choose a comfortable seated position.',
          'Breathe in and out through your nose.',
          'Count during each inhale and exhale to make sure they are even in duration. Alternatively, choose a word or short phrase to repeat during each inhale and exhale.',
          'You can add a slight pause or breath retention after each inhale and exhale if you feel comfortable. (Normal breathing involves a natural pause.)',
          'Continue practicing this breath for at least 5 minutes.'
        ]),
    MeditationExercise(
        id: 4,
        image: 'assets/Resonant or coherent breathing.png',
        title: 'Resonant or coherent breathing',
        description:
            'Resonant breathing, also known as coherent breathing, is when you breathe at a rate of 5 full breaths per minute.',
        instructions: [
          'Inhale for a count of 5.',
          'Exhale for a count of 5.',
          'Continue this breathing pattern for at least a few minutes',
        ]),
    MeditationExercise(
        id: 5,
        image: 'assets/Deep breathing.png',
        title: 'Deep breathing',
        description:
            'Deep breathing helps to relieve shortness of breath by preventing air from getting trapped in your lungs.',
        instructions: [
          'While standing or sitting, draw your elbows back slightly to allow your chest to expand.',
          'Take a deep inhalation through your nose.',
          'Retain your breath for a count of 5.',
          'Slowly release your breath by exhaling through your nose.',
        ]),
    MeditationExercise(
        id: 6,
        image: 'assets/Humming bee breath.png',
        title: 'Humming bee breath ',
        description:
            'The unique sensation of this yoga breathing practice helps to create instant calm and is especially soothing around your forehead.',
        instructions: [
          'Choose a comfortable seated position.',
          'Close your eyes and relax your face.',
          'Place your first fingers on the tragus cartilage that partially covers your ear canal.',
          'Inhale, and as you exhale gently press your fingers into the cartilage.',
          'Keeping your mouth closed, make a loud humming sound.',
          'Continue for as long as is comfortable.',
        ]),
  ];
}
