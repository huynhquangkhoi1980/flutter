// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_req.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_res.dart';
import 'package:mevn_app/kickoff/models/member_res.dart';

abstract class MemberEvaluationsState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  MemberEvaluationsState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnMemberEvaluationsState extends MemberEvaluationsState {
  UnMemberEvaluationsState();

  @override
  String toString() => 'UnMemberEvaluationsState';
}

/// Initialized
class InMemberEvaluationsState extends MemberEvaluationsState {
  InMemberEvaluationsState();

  @override
  String toString() => 'InMemberEvaluationsState';
}

/// Loading
class LoadingState extends MemberEvaluationsState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class MemberEvaluationState extends MemberEvaluationsState {
  MemberEvaluationRes data;
  MemberEvaluationState(this.data);

  @override
  String toString() => 'MemberEvaluationState';
}

// ignore: must_be_immutable
class MemberIsCheckedState extends MemberEvaluationsState {
  List<String>? data;
  MemberIsCheckedState(this.data);

  @override
  String toString() => 'MemberIsCheckedState';
}

// ignore: must_be_immutable
class IsCheckedMenuState extends MemberEvaluationsState {
  bool data;
  IsCheckedMenuState(this.data);

  @override
  String toString() => 'IsCheckedMenuState';
}

// ignore: must_be_immutable
class MembersLoadedState extends MemberEvaluationsState {
  MemberRes data;
  MembersLoadedState(this.data);

  @override
  String toString() => 'MembersLoadedState';
}

// ignore: must_be_immutable
class SendEvaluationState extends MemberEvaluationsState {
  MemberEvaluationReq data;
  SendEvaluationState(this.data);

  @override
  String toString() => 'SendEvaluationState';
}

class ErrorMemberEvaluationsState extends MemberEvaluationsState {
  ErrorMemberEvaluationsState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorMemberEvaluationsState';

  @override
  List<Object> get props => [errorMessage];
}
