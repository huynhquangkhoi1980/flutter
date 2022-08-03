import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/sub_project_req.dart';
import 'package:mevn_app/kickoff/models/sub_project_res.dart';

abstract class SubProjectState extends Equatable {
  const SubProjectState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnSubProjectState extends SubProjectState {
  const UnSubProjectState();

  @override
  String toString() => 'UnSubProjectState';
}

// ignore: must_be_immutable
class SubPjIsCheckedState extends SubProjectState {
  List<String>? data;
  SubPjIsCheckedState(this.data);

  @override
  String toString() => 'SubPjIsCheckedState';
}

/// Initialized
class InSubProjectState extends SubProjectState {
  const InSubProjectState();

  @override
  String toString() => 'InSubProjectState';
}

/// Loading
class LoadingState extends SubProjectState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class ProjectsLoadedState extends SubProjectState {
  SubProjectRes data;
  ProjectsLoadedState(this.data);

  @override
  String toString() => 'ProjectsLoadedState';
}

// ignore: must_be_immutable
class SendSelectionState extends SubProjectState {
  SubProjectReq data;
  SendSelectionState(this.data);

  @override
  String toString() => 'SendSelectionState';
}

class ErrorSubProjectState extends SubProjectState {
  const ErrorSubProjectState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorSubProjectState';

  @override
  List<Object> get props => [errorMessage];
}
