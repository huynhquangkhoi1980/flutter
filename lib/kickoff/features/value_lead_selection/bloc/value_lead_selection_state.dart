import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';
import 'package:mevn_app/kickoff/models/value_lead_selection.dart';

abstract class ValueLeadSelectionState extends Equatable {
  const ValueLeadSelectionState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnValueLeadSelectionState extends ValueLeadSelectionState {
  const UnValueLeadSelectionState();

  @override
  String toString() => 'UnValueLeadSelectionState';
}

/// Initialized
class InValueLeadSelectionState extends ValueLeadSelectionState {
  const InValueLeadSelectionState();

  @override
  String toString() => 'InValueLeadSelectionState';
}

/// Loading
class LoadingState extends ValueLeadSelectionState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class ValueIsCheckedState extends ValueLeadSelectionState {
  List<String>? data;
  ValueIsCheckedState(this.data);

  @override
  String toString() => 'ValueIsCheckedState';
}

// ignore: must_be_immutable
class MembersLoadedState extends ValueLeadSelectionState {
  MemberRes data;
  MembersLoadedState(this.data);

  @override
  String toString() => 'MembersLoadedState';
}

// ignore: must_be_immutable
class CountProductLoadedState extends ValueLeadSelectionState {
  int count;
  CountProductLoadedState(this.count);

  @override
  String toString() => 'CountProductLoadedState';
}

// ignore: must_be_immutable
class SendSelectionState extends ValueLeadSelectionState {
  ValueLeadSelection data;
  SendSelectionState(this.data);

  @override
  String toString() => 'SendSelectionState';
}

class ErrorValueLeadSelectionState extends ValueLeadSelectionState {
  const ErrorValueLeadSelectionState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorValueLeadSelectionState';

  @override
  List<Object> get props => [errorMessage];
}
