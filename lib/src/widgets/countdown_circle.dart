import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class CountDownCircle extends StatefulWidget {
  CountDownCircle({this.duration});
  final Duration duration;
  @override
  _CountDownCircleState createState() => _CountDownCircleState();
}

class _CountDownCircleState extends State<CountDownCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
          painter: _CircleCountdownPainter(
              thinRing: Theme.of(context).accentColor.withOpacity(0.85),
              tickerRing: Theme.of(context).accentColor,
              animation: Tween<double>(begin: 0.0, end: pi * 2).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.linear))),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _CircleCountdownPainter extends CustomPainter {
  _CircleCountdownPainter({this.animation, this.thinRing, this.tickerRing})
      : fillerPaint = Paint()
          ..color = Color(0xFFDB8C39)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 42.0
          ..strokeCap = StrokeCap.round,
        super(repaint: animation);

  final Color thinRing;

  final Color tickerRing;
  final Animation<double> animation;
  final Paint fillerPaint;

  Paint circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.30);
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(
      center,
      radius,
      circlePaint..color = thinRing,
    );

    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        TinyColor(tickerRing).lighten(8).color,
        tickerRing,
        TinyColor(tickerRing).darken(5).color,
      ],
      stops: [0.0, 0.5, 1.0],
    );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(pi * 3 / 2);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawArc(
      rect,
      0,
      animation.value,
      false,
      fillerPaint..shader = gradient.createShader(rect),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CircleCountdownPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
