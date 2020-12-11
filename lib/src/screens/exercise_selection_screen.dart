import 'package:flutter/material.dart';
import 'package:meditation_app/src/excercises.dart';
import 'package:meditation_app/src/widgets/meditation_card.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  @override
  _ExerciseSelectionScreenState createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text('Exercises'),
              elevation: 8,
              floating: true,
              snap: true,
              leading: IconButton(
                icon: new Icon(Icons.arrow_back,
                    color: Theme.of(context).accentColor),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ),
          ];
        },
        body: Container(
          child: ListView.builder(
              itemCount: Exercises.exercises.length,
              itemBuilder: (context, index) {
                return MeditationCard(Exercises.exercises[index],
                    horizontal: true);
              }),
        ),
      ),
    );
  }
}
