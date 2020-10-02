import 'package:flutter/material.dart';
import 'package:meditation_app/page_routes.dart';
import 'package:meditation_app/src/models/meditation_exercise.dart';
import 'package:meditation_app/src/screens/exercise_details_screen.dart';

class MeditationCard extends StatelessWidget {
  final MeditationExercise _meditationExercise;
  final bool horizontal;

  MeditationCard(this._meditationExercise, {this.horizontal = false});
  MeditationCard.vertical(this._meditationExercise, {this.horizontal = true});

  @override
  Widget build(BuildContext context) {
    String steps = _meditationExercise.instructions.length.toString();

    final meditationThumbnail = Container(
      alignment: horizontal ? null : FractionalOffset.topCenter,
      margin: EdgeInsets.symmetric(
        vertical: horizontal ? 20.0 : 10,
      ),
      child: Hero(
        tag: 'Exercise-her-${_meditationExercise.id}',
        child: ClipOval(
          child: Image(
            image: AssetImage(_meditationExercise.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    final exerciseCardContent = Container(
      margin: EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            _meditationExercise.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(height: 5.0),
          Text("Steps: $steps",
              style: horizontal
                  ? TextStyle(fontSize: 12.0)
                  : Theme.of(context).textTheme.bodyText1),
          horizontal
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  height: 2.0,
                  width: 45.0,
                  color: Color(0xff00c6ff))
              : Container(),
          horizontal
              ? Expanded(
                  child: Text(
                    _meditationExercise.description,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Container()
        ],
      ),
    );

    final meditationCard = Container(
      height: horizontal ? 156.0 : 210.0,
      margin: horizontal
          ? EdgeInsets.only(left: 28, right: 10)
          : EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(.6),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: exerciseCardContent,
    );

    return GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(PageRoutes.slide(
              () => ExerciseDetails(_meditationExercise),
              milliseconds: 300))
          : null,
      child: Container(
        height: 210,
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Stack(
          children: [meditationCard, meditationThumbnail],
        ),
      ),
    );
  }
}
