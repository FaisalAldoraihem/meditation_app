import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/I10n/l10n.dart';
import 'package:meditation_app/page_routes.dart';
import 'package:meditation_app/src/screens/completion_screen.dart';
import 'package:meditation_app/src/screens/mainScreens/main_screen.dart';
import 'package:meditation_app/src/widgets/countdown_circle.dart';
import 'package:meditation_app/src/widgets/meditation_animation.dart';
import 'package:meditation_app/utils/extensions.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../utils/utils.dart';
import '../../models/quote.dart';

class MeditationMode extends StatefulWidget {
  final Duration duration;
  final bool zenMode;
  final bool playSounds;
  MeditationMode(this.duration, {this.zenMode, this.playSounds, Key key})
      : super(key: key);

  @override
  _MeditationModeState createState() => _MeditationModeState();
}

class _MeditationModeState extends State<MeditationMode> {
  Stopwatch _stopwatch;
  Timer _timer;
  Duration _elapsedTime;
  String _display = 'Be at peace';

  void _playSound() {
    if (widget.playSounds) {
      final assetsAudioPlayer = AssetsAudioPlayer();
      assetsAudioPlayer.open(
        Audio("assets/gong.mp3"),
        autoStart: true,
      );
    }
  }

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }

    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      setState(() {
        var diff = (_elapsedTime - _stopwatch.elapsed);
        _display = diff.clockFmt();
        if (diff.inMilliseconds <= 0) {
          _playSound();
          stop(cancelled: false);
        }
      });
    });
  }

  void pause() {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _stopwatch.stop();
    });
  }

  void stop({bool cancelled = true}) {
    if (!_stopwatch.isRunning) {
      return;
    }
    setState(() {
      _timer.cancel();
      _stopwatch.stop();
    });

    if (cancelled) {
      Navigator.of(context).pushReplacement(
          PageRoutes.fade(() => MainScreen(), milliseconds: 450));
    } else {
      Navigator.of(context).pushReplacement(
          PageRoutes.fade(() => CompletionScreen(), milliseconds: 800));
    }
  }

  @override
  void initState() {
    super.initState();
    _playSound();
    _elapsedTime = widget.duration;
    _stopwatch = Stopwatch();
    start();
  }

  @override
  Widget build(BuildContext context) {
    Quote quote = getQuote(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            Text(
              '“${quote.body}”',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.0),
            Text(
              quote.author,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 10.0),
          ],
        ),
        widget.zenMode
            ? Expanded(child: MeditationAnimation())
            : Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox.expand(
                      child: CountDownCircle(
                        duration: widget.duration,
                      ),
                    ),
                    Container(
                      child: Text(
                        _display,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(68.0)),
              color: Theme.of(context).disabledColor,
              onPressed: () => stop(),
              child: Text(
                S.of(context).endButton.toUpperCase(),
                style: GoogleFonts.varelaRound(
                  color: Color(0xFF707073),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ).padding(all: 18.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _stopwatch.stop();
  }
}
