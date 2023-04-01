import 'package:equatable/equatable.dart';

import '../../../models/book.dart';

abstract class BookRegisterState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  BookRegisterState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnRegisterBookState extends BookRegisterState {
  UnRegisterBookState();

  @override
  String toString() => 'UnRegisterBookState';
}

/// Initialized
class InRegisterBookState extends BookRegisterState {
  InRegisterBookState();

  @override
  String toString() => 'InRegisterBookState';
}

// Loading
class LoadingState extends BookRegisterState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

// ignore: must_be_immutable
class SendRegisterBookState extends BookRegisterState {
  Book? data;
  SendRegisterBookState(this.data);

  @override
  String toString() => 'SendRegisterBookState';
}

class ErrorRegisterBookState extends BookRegisterState {
  ErrorRegisterBookState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorRegisterBookState';

  @override
  List<Object> get props => [errorMessage];
}
