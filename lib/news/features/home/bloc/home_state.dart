// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';
import 'package:mevn_app/news/models/home_res.dart';

abstract class HomeState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  HomeState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnHomeState extends HomeState {
  UnHomeState();

  @override
  String toString() => 'UnHomeState';
}

/// Initialized
class InHomeState extends HomeState {
  InHomeState();

  @override
  String toString() => 'InHomeState';
}

class LoadingState extends HomeState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

class HomeLoadedState extends HomeState {
  final HomeRes data;
  HomeLoadedState(this.data);

  @override
  String toString() => 'HomeLoadedState';
}

class ErrorHomeState extends HomeState {
  ErrorHomeState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorHomeState';

  @override
  List<Object> get props => [errorMessage];
}
