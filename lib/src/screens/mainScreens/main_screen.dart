import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:meditation_app/config/app_config.dart' as AppTheme;
import 'package:flutter/material.dart';
import 'package:meditation_app/constants/settings.dart';
import 'package:meditation_app/src/screens/about_screen.dart';
import 'package:meditation_app/src/screens/mainScreens/selection_screen.dart';
import 'package:meditation_app/src/widgets/drawer/drawer.dart';
import 'package:meditation_app/src/widgets/drawer/drawer_user_con.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  AnimationController sliderAnimationController;
  DateTime newDateTime;
  TimeOfDay timePicked;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = SelectionScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.Colors().notWhite(1),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.alarm),
            onPressed: () async {
              newDateTime = await showRoundedDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
                borderRadius: 16,
              );
              timePicked = await showRoundedTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              _setNotification();
            },
          ),
          backgroundColor: AppTheme.Colors().notWhite(1),
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            animationController: (AnimationController animationController) {
              sliderAnimationController = animationController;
            },
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = SelectionScreen(
            startingAnimation: true,
          );
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutScreen();
        });
      } else {
        setState(() {
          screenView = AboutScreen();
        });
      }
    }
  }

  void _setNotification() {
    if (newDateTime != null && timePicked != null) {
      Provider.of<MeditationModel>(context, listen: false)
          .localNotifications
          .setNotificationWithDate(
              newDateTime.day, timePicked.hour, timePicked.minute);
    }
  }
}
