import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';
import 'package:mevn_app/kickoff/models/tech_lead_selection.dart';

abstract class TechLeadSelectionState extends Equatable {
  const TechLeadSelectionState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnTechLeadSelectionState extends TechLeadSelectionState {
  const UnTechLeadSelectionState();

  @override
  String toString() => 'UnTechLeadSelectionState';
}

/// Initialized
class InTechLeadSelectionState extends TechLeadSelectionState {
  const InTechLeadSelectionState();

  @override
  String toString() => 'InTechLeadSelectionState';
}

/// Loading
class LoadingState extends TechLeadSelectionState {
  const LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class MembersLoadedState extends TechLeadSelectionState {
  MemberRes data;
  MembersLoadedState(this.data);

  @override
  String toString() => 'MembersLoadedState';
}

// ignore: must_be_immutable
class CountProductLoadedState extends TechLeadSelectionState {
  int count;
  CountProductLoadedState(this.count);

  @override
  String toString() => 'CountProductLoadedState';
}

// ignore: must_be_immutable
class TechIsCheckedState extends TechLeadSelectionState {
  List<String>? data;
  TechIsCheckedState(this.data);

  @override
  String toString() => 'TechIsCheckedState';
}

// ignore: must_be_immutable
class SendSelectionState extends TechLeadSelectionState {
  TechLeadSelection data;
  SendSelectionState(this.data);

  @override
  String toString() => 'SendSelectionState';
}

class ErrorTechLeadSelectionState extends TechLeadSelectionState {
  const ErrorTechLeadSelectionState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorTechLeadSelectionState';

  @override
  List<Object> get props => [errorMessage];
}
