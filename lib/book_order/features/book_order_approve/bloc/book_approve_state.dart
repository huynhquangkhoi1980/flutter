import 'package:equatable/equatable.dart';

import '../../../models/book.dart';

abstract class BookApproveState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  BookApproveState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnApproveBookState extends BookApproveState {
  UnApproveBookState();

  @override
  String toString() => 'UnApproveBookState';
}

/// Initialized
class InApproveBookState extends BookApproveState {
  InApproveBookState();

  @override
  String toString() => 'InApproveBookState';
}

// Loading
class LoadingApproveState extends BookApproveState {
  LoadingApproveState();

  @override
  String toString() => 'LoadingApproveState';
}

// ignore: must_be_immutable
class SendApproveBookState extends BookApproveState {
  Book? data;
  SendApproveBookState(this.data);

  @override
  String toString() => 'SendApproveBookState';
}

class ErrorApproveBookState extends BookApproveState {
  ErrorApproveBookState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorApproveBookState';

  @override
  List<Object> get props => [errorMessage];
}
