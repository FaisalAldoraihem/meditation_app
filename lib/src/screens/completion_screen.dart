import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditation_app/I10n/l10n.dart';
import 'package:meditation_app/page_routes.dart';
import 'package:meditation_app/src/models/quote.dart';
import 'package:meditation_app/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Quote quote = getQuote(context);
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image(image: AssetImage('assets/images/c1.png')),
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
                SizedBox(height: 36.0),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(68.0)),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(PageRoutes.fade(
                            () => App(),
                            milliseconds: 800,
                          ));
                        },
                        child: Text(
                          S.of(context).rateButton.toUpperCase(),
                          style: GoogleFonts.varelaRound(
                            color: Color(0xFFE7E7E8),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ).padding(all: 18.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(68.0)),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          Alert(
                            context: context,
                            type: AlertType.info,
                            title: "What do you rate our app?",
                            content: RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                              ),
                              DialogButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(116, 116, 191, 1.0),
                                  Color.fromRGBO(52, 138, 199, 1.0)
                                ]),
                              )
                            ],
                          ).show();
                        },
                        child: Text(
                          S.of(context).homeButton.toUpperCase(),
                          style: GoogleFonts.varelaRound(
                            color: Color(0xFFE7E7E8),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ).padding(all: 18.0),
                      ),
                    ),
                  ],
                )
              ],
            ).padding(horizontal: 48.0),
          ),
        ),
      ),
    );
  }
}
