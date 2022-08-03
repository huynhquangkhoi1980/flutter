import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/menu_kickoff_req.dart';

abstract class KickoffMainState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  KickoffMainState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnKickoffMainState extends KickoffMainState {
  UnKickoffMainState();

  @override
  String toString() => 'UnKickoffMainState';
}

/// Initialized
class InKickoffMainState extends KickoffMainState {
  InKickoffMainState();

  @override
  String toString() => 'InKickoffMainState';
}

/// Loading
class LoadingState extends KickoffMainState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class KickoffMainsLoadedState extends KickoffMainState {
  MenuKickoffRes data;
  KickoffMainsLoadedState(this.data);

  @override
  String toString() => 'KickoffMainsLoadedState';
}

class ErrorKickoffMainState extends KickoffMainState {
  ErrorKickoffMainState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorKickoffMainState';

  @override
  List<Object> get props => [errorMessage];
}
