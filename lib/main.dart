import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/simple_bloc_delegate.dart';

import 'src/screens/splash_screen.dart';

void main() {
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
    BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return MeditationSplashScreen();
            }
            if (state is Authenticated) {
              return Container(child: Text("hello"));
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }
}
