import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/route_generator.dart';
import 'package:meditation_app/src/screens/loginAndSignup/login_screen.dart';
import 'blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/simple_bloc_delegate.dart';
import 'package:meditation_app/config/app_config.dart' as config;

import 'src/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _authenticationBloc,
        child: MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              if (state is Uninitialized) {
                return MeditationSplashScreen();
              } else if (state is Unauthenticated) {
                return LoginScreen.main(userRepository: _userRepository);
              } else {
                return Container();
              }
            },
          ),
          darkTheme: ThemeData(
            fontFamily: 'Hell',
            primaryColor: Color(0xFF252525),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF2C2C2C),
            accentColor: config.Colors().mainDarkColor(1),
            hintColor: config.Colors().secondDarkColor(1),
            focusColor: config.Colors().accentDarkColor(1),
            textTheme: TextTheme(
              button: TextStyle(color: Color(0xFF252525)),
              headline: TextStyle(
                  fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
              display1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondDarkColor(1)),
              display2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondDarkColor(1)),
              display3: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: config.Colors().mainDarkColor(1)),
              display4: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  color: config.Colors().secondDarkColor(1)),
              subhead: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: config.Colors().secondDarkColor(1)),
              title: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().mainDarkColor(1)),
              body1: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
              body2: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondDarkColor(1)),
              caption: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
            ),
          ),
          theme: ThemeData(
            fontFamily: 'Hell',
            primaryColor: Colors.white,
            brightness: Brightness.light,
            accentColor: config.Colors().mainColor(1),
            focusColor: config.Colors().accentColor(1),
            hintColor: config.Colors().secondColor(1),
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              headline: TextStyle(
                  fontSize: 20.0, color: config.Colors().secondColor(1)),
              display1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondColor(1)),
              display2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondColor(1)),
              display3: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: config.Colors().mainColor(1)),
              display4: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  color: config.Colors().secondColor(1)),
              subhead: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: config.Colors().secondColor(1)),
              title: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().mainColor(1)),
              body1: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondColor(1)),
              body2: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondColor(1)),
              caption: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondColor(0.6)),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }
}
