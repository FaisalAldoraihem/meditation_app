import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/blocs/registerBloc/register_bloc.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/src/models/route_argument.dart';
import 'package:meditation_app/src/screens/loginAndSignup/register_form.dart';

class RegisterScreen extends StatefulWidget {
  UserRepository _userRepository;

  RegisterScreen({Key key, @required RouteArgument routeArgument})
      : assert(routeArgument != null),
        super(key: key) {
    _userRepository = routeArgument.argumentsList[0] as UserRepository;
  }

  RegisterScreen.main({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc _registerBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(
      userRepository: _userRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (BuildContext context) => _registerBloc,
          child: RegisterForm(
            userRepository: _userRepository,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }
}
