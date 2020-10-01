part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]);
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
  @override
  List<Object> get props => throw UnimplementedError();
}

class Authenticated extends AuthenticationState {
  final String displayName;

  Authenticated(this.displayName) : super([displayName]);

  @override
  String toString() => 'Authenticated { displayName: $displayName }';

  @override
  List<Object> get props => throw UnimplementedError();
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
  @override
  List<Object> get props => throw UnimplementedError();
}

class Register extends AuthenticationState {
  @override
  String toString() => 'Register';
  @override
  List<Object> get props => throw UnimplementedError();
}
