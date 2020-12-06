import 'package:flutter/material.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/src/models/meditation_exercise.dart';
import 'package:meditation_app/src/widgets/meditation_card.dart';
import 'package:provider/provider.dart';

class ExerciseDetails extends StatelessWidget {
  final MeditationExercise _meditationExercise;

  ExerciseDetails(this._meditationExercise);

  @override
  Widget build(BuildContext context) {
    Container _getToolbar(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: BackButton(color: Theme.of(context).accentColor),
      );
    }

    Widget _getContent() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MeditationCard(_meditationExercise, horizontal: false),
            SizedBox(
              height: 10,
            ),
            Text(
              _meditationExercise.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: Color(0xff00c6ff)),
            Text(_meditationExercise.description,
                style: Theme.of(context).textTheme.bodyText1),
            ListView.builder(
              itemCount: _meditationExercise.instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                      decoration: new BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  )),
                  title: Text(_meditationExercise.instructions[index]),
                );
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF736AB7),
        elevation: 10,
        child: RaisedButton(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Select Exercise',
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
            onPressed: () {
              Provider.of<MeditationModel>(context, listen: false).exercise =
                  _meditationExercise;
              Navigator.pop(context);
            }),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0x00736AB7), Color(0xFF736AB7)],
            stops: [0.0, 0.9],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
          ),
        ),
        child: Stack(
          children: [_getToolbar(context), _getContent()],
        ),
      ),
    );
  }
}
