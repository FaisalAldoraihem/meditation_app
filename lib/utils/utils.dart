import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meditation_app/constants/quotes.dart';
import 'package:meditation_app/src/models/quote.dart';

bool isDark(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  return brightness == Brightness.dark;
}

/// A function that returns a random quote from [kDefaultQuotes]
Quote getQuote(BuildContext context) {
  var r = Random(DateTime.now().millisecondsSinceEpoch);
  final quotes = kDefaultQuotes(context);
  var randInt = r.nextInt(quotes.length);
  return quotes[randInt];
}
