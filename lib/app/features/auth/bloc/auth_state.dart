// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AuthState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnAuthState extends AuthState {
  UnAuthState();

  @override
  String toString() => 'UnAuthState';
}

/// Initialized
class InAuthState extends AuthState {
  InAuthState();

  @override
  String toString() => 'InAuthState';
}

class LoadedAppState extends AuthState {
  LoadedAppState();

  @override
  String toString() => 'LoadedAppState';
}

// ignore: must_be_immutable
class LoginState extends AuthState {
  dynamic data;
  LoginState(this.data);

  @override
  String toString() => 'LoginState';
}

// ignore: must_be_immutable
class AuthenticationState extends AuthState {
  bool authentication;
  AuthenticationState(this.authentication);

  @override
  String toString() => 'AuthenticationState';
}

class LogoutState extends AuthState {
  LogoutState();

  @override
  String toString() => 'LogoutState';
}

class ErrorAuthState extends AuthState {
  ErrorAuthState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorAuthState';

  @override
  List<Object> get props => [errorMessage];
}
