part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
  @override
  List<Object> get props => throw UnimplementedError();
}
