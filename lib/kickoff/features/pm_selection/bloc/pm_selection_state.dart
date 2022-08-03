import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';
import 'package:mevn_app/kickoff/models/pm_selection.dart';

abstract class PmSelectionState extends Equatable {
  const PmSelectionState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnPmSelectionState extends PmSelectionState {
  const UnPmSelectionState();

  @override
  String toString() => 'UnPmSelectionState';
}

/// Initialized
class InPmSelectionState extends PmSelectionState {
  const InPmSelectionState();

  @override
  String toString() => 'InPmSelectionState';
}

/// Loading
class LoadingState extends PmSelectionState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class PMIsCheckedState extends PmSelectionState {
  List<String>? data;
  PMIsCheckedState(this.data);

  @override
  String toString() => 'PMIsCheckedState';
}

// ignore: must_be_immutable
class MembersLoadedState extends PmSelectionState {
  MemberRes data;
  MembersLoadedState(this.data);

  @override
  String toString() => 'MembersLoadedState';
}

// ignore: must_be_immutable
class CountProductLoadedState extends PmSelectionState {
  int count;
  CountProductLoadedState(this.count);

  @override
  String toString() => 'CountProductLoadedState';
}

// ignore: must_be_immutable
class SendSelectionState extends PmSelectionState {
  PmSelection data;
  SendSelectionState(this.data);

  @override
  String toString() => 'SendSelectionState';
}

class ErrorPmSelectionState extends PmSelectionState {
  const ErrorPmSelectionState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorPmSelectionState';

  @override
  List<Object> get props => [errorMessage];
}
