import 'package:dynamic_theme/dynamic_theme.dart';
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
import 'package:meditation_app/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/simple_bloc_delegate.dart';
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
  List<ThemeItem> data = List();
  String dynTheme;
  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  Future<void> getDefault() async {
    data = ThemeItem.getThemes();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynTheme = prefs.getString("dynTheme") ?? 'light-purple-amber';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _authenticationBloc,
        child: ChangeNotifierProvider(
          create: (_) => MeditationModel(localNotifications),
          child: DynamicTheme(
              defaultBrightness: Brightness.light,
              data: (Brightness brightness) {
                getDefault();
                for (int i = 0; i < data.length; i++) {
                  if (data[i].slug == this.dynTheme) {
                    return data[i].themeData;
                  }
                }
                return data[0].themeData;
              },
              themedWidgetBuilder: (context, theme) {
                return MaterialApp(
                  theme: theme,
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
                            child:
                                LoginScreen(userRepository: _userRepository));
                      } else if (state is Register) {
                        return AnimatedSwitcher(
                            duration: Duration(milliseconds: 350),
                            child: RegisterScreen(
                                userRepository: _userRepository));
                      } else {
                        return AnimatedSwitcher(
                            duration: Duration(milliseconds: 350),
                            child: MainScreen());
                      }
                    },
                  ),
                );
              }),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }
}
