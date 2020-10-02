import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/I10n/l10n.dart';
import 'package:meditation_app/config/ui_icons.dart';
import 'package:meditation_app/constants/preset_timers.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/page_routes.dart';
import 'package:meditation_app/src/screens/exercise_selection_screen.dart';
import 'package:meditation_app/src/widgets/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:styled_widget/styled_widget.dart';

class SelectionScreen extends StatefulWidget {
  SelectionScreen({this.startingAnimation = false, Key key}) : super(key: key);

  final bool startingAnimation;

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>
    with TickerProviderStateMixin {
  bool playSounds;
  bool isZenMode;
  Duration _presetDuration;

  @override
  void initState() {
    super.initState();
    playSounds =
        Provider.of<MeditationModel>(context, listen: false).playSounds;
    isZenMode = Provider.of<MeditationModel>(context, listen: false).isZenMode;
    _presetDuration =
        Provider.of<MeditationModel>(context, listen: false).duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Breath',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      S.of(context).tagline,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SettingsCard(
                        start: true,
                        title: Text(
                          S.of(context).durationSettingLabel,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        leading: Icon(Icons.hourglass_empty),
                        trailing: DropdownButton<Duration>(
                          underline: Container(),
                          items: kPresetTimers.map((preset) {
                            return DropdownMenuItem<Duration>(
                              value: preset,
                              child: Text(
                                S.of(context).presetDuration(preset.inMinutes),
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            );
                          }).toList(),
                          value: _presetDuration,
                          onChanged: (value) {
                            setState(() {
                              Provider.of<MeditationModel>(context,
                                      listen: false)
                                  .duration = value;
                              _presetDuration = value;
                            });
                          },
                        ),
                      ),
                      SettingsCard(
                        title: Text(
                          S.of(context).playSoundSettingLabel,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        leading: Icon(UiIcons.music),
                        trailing: cupertino.CupertinoSwitch(
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (value) {
                            setState(() {
                              playSounds = value;
                              Provider.of<MeditationModel>(context,
                                      listen: false)
                                  .playSounds = value;
                            });
                          },
                          value:
                              Provider.of<MeditationModel>(context).playSounds,
                        ),
                      ),
                      SettingsCard(
                        title: Text(
                          S.of(context).zenModeSettingLabel,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        leading: Icon(UiIcons.heart),
                        trailing: cupertino.CupertinoSwitch(
                          activeColor: Theme.of(context).accentColor,
                          onChanged: (bool value) {
                            setState(() {
                              isZenMode = value;
                              Provider.of<MeditationModel>(context,
                                      listen: false)
                                  .isZenMode = value;
                            });
                          },
                          value:
                              Provider.of<MeditationModel>(context).isZenMode,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(PageRoutes.slide(
                            () => ExerciseSelectionScreen(),
                            milliseconds: 300)),
                        child: SettingsCard(
                          end: true,
                          title: Text(
                            S.of(context).breathingMeditationType,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          leading: Icon(UiIcons.planet_earth),
                          trailing: cupertino.Icon(Icons.arrow_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(68.0),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      //Todo meditate b
                    },
                    child: Text(
                      S.of(context).beginButton.toUpperCase(),
                      style: GoogleFonts.varelaRound(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ).padding(all: 18.0),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
