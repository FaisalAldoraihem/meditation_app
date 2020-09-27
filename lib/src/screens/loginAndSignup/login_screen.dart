import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/blocs/loginBloc/login_bloc.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/src/models/route_argument.dart';
import 'package:meditation_app/src/screens/loginAndSignup/login_form.dart';

class LoginScreen extends StatefulWidget {
  UserRepository _userRepository;

  LoginScreen({Key key, @required RouteArgument routeArgument})
      : assert(routeArgument != null),
        super(key: key) {
    _userRepository = routeArgument.argumentsList[0] as UserRepository;
  }

  LoginScreen.main({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => _loginBloc,
      child: LoginForm(
        userRepository: _userRepository,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }
}
