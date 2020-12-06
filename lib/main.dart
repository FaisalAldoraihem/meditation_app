import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:meditation_app/I10n/l10n.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/repositorys/local_notifications.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/route_generator.dart';
import 'package:meditation_app/src/screens/loginAndSignup/login_screen.dart';
import 'package:meditation_app/src/screens/loginAndSignup/register_screen.dart';
import 'package:meditation_app/src/screens/mainScreens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/simple_bloc_delegate.dart';
import 'package:meditation_app/config/app_config.dart' as config;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'src/screens/splash_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final LocalNotifications localNotifications =
    LocalNotifications(flutterLocalNotificationsPlugin);

SharedPreferences _preferences;

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
}

void setDisplayName() {
  if (_preferences.containsKey('displayName')) return;

  _preferences.setString('displayName', 'yabeb');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _configureLocalTimeZone();
  await localNotifications.setUpNotifications();
  _preferences = await SharedPreferences.getInstance();
  setDisplayName();
  Bloc.observer = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(App());
  });
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
        child: ChangeNotifierProvider(
          create: (_) => MeditationModel(localNotifications),
          child: MaterialApp(
            title: 'Breath',
            localizationsDelegates: [S.delegate],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return ResponsiveWrapper.builder(
                widget,
                maxWidth: 1200,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(450, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
              );
            },
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, AuthenticationState state) {
                if (state is Uninitialized) {
                  return AnimatedSwitcher(
                      duration: Duration(milliseconds: 350),
                      child: MeditationSplashScreen());
                } else if (state is Unauthenticated) {
                  return AnimatedSwitcher(
                      duration: Duration(milliseconds: 350),
                      child: LoginScreen(userRepository: _userRepository));
                } else if (state is Register) {
                  return AnimatedSwitcher(
                      duration: Duration(milliseconds: 350),
                      child: RegisterScreen(userRepository: _userRepository));
                } else {
                  return AnimatedSwitcher(
                      duration: Duration(milliseconds: 350),
                      child: MainScreen());
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
                    fontSize: 12.0,
                    color: config.Colors().secondDarkColor(0.7)),
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
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }
}
