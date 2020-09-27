import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/loginBloc/login_bloc.dart';
import 'package:meditation_app/config/ui_icons.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/config/app_config.dart' as config;
import 'package:meditation_app/src/models/route_argument.dart';
import 'package:meditation_app/src/widgets/google_login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  bool _showPassword = false;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: config.Colors().accentColor(1),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: config.Colors().mainColor(0.6),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        margin:
                            EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: config.Colors().mainColor(1),
                            boxShadow: [
                              BoxShadow(
                                  color: config.Colors().accentDarkColor(.2),
                                  offset: Offset(0, 10),
                                  blurRadius: 20)
                            ]),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 25),
                            Text('Sign In',
                                style: Theme.of(context).textTheme.display3),
                            SizedBox(height: 20),
                            TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isEmailValid
                                    ? 'Invalid Email'
                                    : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .merge(
                                      TextStyle(
                                          color:
                                              config.Colors().accentColor(1)),
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor)),
                                prefixIcon: Icon(
                                  UiIcons.envelope,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                              keyboardType: TextInputType.text,
                              obscureText: !_showPassword,
                              controller: _passwordController,
                              autovalidate: true,
                              autocorrect: false,
                              validator: (_) {
                                return !state.isPasswordValid
                                    ? 'Invalid Password'
                                    : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .merge(
                                      TextStyle(
                                          color: Theme.of(context).accentColor),
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).accentColor)),
                                prefixIcon: Icon(
                                  UiIcons.padlock_1,
                                  color: Theme.of(context).accentColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.4),
                                  icon: Icon(_showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            FlatButton(
                              onPressed: () {
                                //Todo forgot password
                              },
                              child: Text(
                                'Forgot your password ?',
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                            SizedBox(height: 30),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 70),
                              onPressed: () => isLoginButtonEnabled(state)
                                  ? _onFormSubmitted()
                                  : null,
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.title.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                            ),
                            SizedBox(height: 50),
                            Text(
                              'Or using social media',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(height: 20),
                            GoogleLoginButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/registerScreen', (Route<dynamic> route) => false,
                          arguments:
                              RouteArgument(argumentsList: [_userRepository]));
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.title.merge(
                              TextStyle(color: Theme.of(context).primaryColor),
                            ),
                        children: [
                          TextSpan(text: 'Don\'t have an account ?'),
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
