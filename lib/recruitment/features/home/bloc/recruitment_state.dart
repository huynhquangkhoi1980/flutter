// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';
import 'package:mevn_app/recruitment/models/skill_res.dart';

abstract class RecruitmentState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  RecruitmentState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnRecruitmentState extends RecruitmentState {
  UnRecruitmentState();

  @override
  String toString() => 'UnRecruitmentState';
}

/// Initialized
class InRecruitmentState extends RecruitmentState {
  InRecruitmentState();

  @override
  String toString() => 'InRecruitmentState';
}

class LoadingState extends RecruitmentState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

class SkillsLoadedState extends RecruitmentState {
  final SkillRes data;
  SkillsLoadedState(this.data);

  @override
  String toString() => 'SkillsLoadedState';
}

class ErrorRecruitmentState extends RecruitmentState {
  ErrorRecruitmentState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorRecruitmentState';

  @override
  List<Object> get props => [errorMessage];
}
