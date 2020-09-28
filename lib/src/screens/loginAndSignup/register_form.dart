import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditation_app/blocs/authBloc/authentication_bloc.dart';
import 'package:meditation_app/blocs/registerBloc/register_bloc.dart';
import 'package:meditation_app/config/ui_icons.dart';
import 'package:meditation_app/repositorys/user_repo.dart';
import 'package:meditation_app/src/models/route_argument.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository _userRepository;

  RegisterForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool get passMatch => _emailController.text == _passwordController.text;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (BuildContext context, state) {
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Registering...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
      }
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Registration Failure'),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
    }, child: BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      margin:
                          EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
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
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text('Sign Up',
                              style: Theme.of(context).textTheme.display3),
                          SizedBox(height: 20),
                          TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                            focusNode: _emailFocus,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, _emailFocus, _passFocus);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
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
                                UiIcons.envelope,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                            focusNode: _passFocus,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, _passFocus, _confirmFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                                    .withOpacity(.4),
                                icon: Icon(_showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(1)),
                            keyboardType: TextInputType.text,
                            controller: _passwordConfirmController,
                            obscureText: !_showPassword,
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !(_passwordController.text ==
                                      _passwordConfirmController.text)
                                  ? 'Passwords Don\'t match'
                                  : null;
                            },
                            focusNode: _confirmFocus,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle:
                                  Theme.of(context).textTheme.body1.merge(
                                        TextStyle(
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(1)),
                                      ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(1))),
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
                                    .withOpacity(.2),
                                icon: Icon(_showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 70),
                            onPressed: () => isRegisterButtonEnabled(state)
                                ? _onFormSubmitted()
                                : null,
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.title.merge(
                                    TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                          //todo social sign up
                        ],
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginScreen', (Route<dynamic> route) => false,
                        arguments:
                            RouteArgument(argumentsList: [_userRepository]));
                  },
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.title.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1)),
                          ),
                      children: [
                        TextSpan(text: 'Already have an account ?'),
                        TextSpan(
                            text: ' Sign In',
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
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
