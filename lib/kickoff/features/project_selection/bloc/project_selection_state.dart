import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/project_req.dart';
import 'package:mevn_app/kickoff/models/project_res.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnProjectState extends ProjectState {
  const UnProjectState();

  @override
  String toString() => 'UnProjectState';
}

/// Initialized
class InProjectState extends ProjectState {
  const InProjectState();

  @override
  String toString() => 'InProjectState';
}

/// Loading
class LoadingState extends ProjectState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class ProjectsLoadedState extends ProjectState {
  ProjectRes data;
  ProjectsLoadedState(this.data);

  @override
  String toString() => 'ProjectsLoadedState';
}

// ignore: must_be_immutable
class PjIsCheckedState extends ProjectState {
  List<String>? data;
  PjIsCheckedState(this.data);

  @override
  String toString() => 'PjIsCheckedState';
}

// ignore: must_be_immutable
class SendSelectionState extends ProjectState {
  ProjectReq data;
  SendSelectionState(this.data);

  @override
  String toString() => 'SendSelectionState';
}

class ErrorProjectState extends ProjectState {
  const ErrorProjectState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorProjectState';

  @override
  List<Object> get props => [errorMessage];
}
