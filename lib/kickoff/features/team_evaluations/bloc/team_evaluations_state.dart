// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_res.dart';
import 'package:mevn_app/kickoff/models/team_res.dart';

abstract class TeamEvaluationsState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  TeamEvaluationsState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnTeamEvaluationsState extends TeamEvaluationsState {
  UnTeamEvaluationsState();

  @override
  String toString() => 'UnTeamEvaluationsState';
}

/// Initialized
class InTeamEvaluationsState extends TeamEvaluationsState {
  InTeamEvaluationsState();

  @override
  String toString() => 'InTeamEvaluationsState';
}

/// Loading
class LoadingState extends TeamEvaluationsState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class EvaluationLoadedState extends TeamEvaluationsState {
  TeamEvaluationRes data;
  EvaluationLoadedState(this.data);

  @override
  String toString() => 'EvaluationLoadedState';
}

// ignore: must_be_immutable
class TeamIsCheckedState extends TeamEvaluationsState {
  List<String>? data;
  TeamIsCheckedState(this.data);

  @override
  String toString() => 'TeamIsCheckedState';
}

// ignore: must_be_immutable
class TeamDataLoadedState extends TeamEvaluationsState {
  TeamsRes data;
  TeamDataLoadedState(this.data);

  @override
  String toString() => 'TeamDataLoadedState';
}

// ignore: must_be_immutable
class SendEvaluationState extends TeamEvaluationsState {
  TeamEvaluationReq data;
  SendEvaluationState(this.data);

  @override
  String toString() => 'SendEvaluationState';
}

// ignore: must_be_immutable
class IsCheckedMenuState extends TeamEvaluationsState {
  bool isCheckMenu;
  IsCheckedMenuState(this.isCheckMenu);

  @override
  String toString() => 'IsCheckedMenuState';
}

class ErrorTeamEvaluationsState extends TeamEvaluationsState {
  ErrorTeamEvaluationsState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorTeamEvaluationsState';

  @override
  List<Object> get props => [errorMessage];
}
