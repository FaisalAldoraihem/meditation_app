import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/I10n/l10n.dart';
import 'package:meditation_app/config/ui_icons.dart';
import 'package:meditation_app/constants/preset_timers.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/src/widgets/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:styled_widget/styled_widget.dart';

class MainScreen extends StatefulWidget {
  MainScreen({this.startingAnimation = false, Key key}) : super(key: key);

  final bool startingAnimation;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool playSounds;
  bool isZenMode;
  Duration _presetDuration;

  AnimationController _scaffold;
  AnimationController _logo;
  Animation<Offset> _animation;
  Animation<Offset> _logoAnimation;

  @override
  void initState() {
    super.initState();
    playSounds =
        Provider.of<MeditationModel>(context, listen: false).playSounds;
    isZenMode = Provider.of<MeditationModel>(context, listen: false).isZenMode;
    _presetDuration =
        Provider.of<MeditationModel>(context, listen: false).duration;

    _scaffold = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));
    /* _logo = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));*/
    _animation =
        Tween<Offset>(begin: Offset(0, 0.25), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    /* _logoAnimation =
        Tween<Offset>(begin: Offset(0, 0.65), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _logo,
        curve: Interval(
          0.25,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
*/
    if (widget.startingAnimation) {
      _scaffold.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Scaffold(
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
                      IconButton(
                          icon: Icon(
                            UiIcons.information,
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                .withOpacity(0.25),
                          ),
                          onPressed: () {
                            //todo about/contact screen
                          }),
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
                                  S
                                      .of(context)
                                      .presetDuration(preset.inMinutes),
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
                            value: Provider.of<MeditationModel>(context)
                                .playSounds,
                          ),
                        ),
                        SettingsCard(
                          end: true,
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
      ),
    );
  }
}
