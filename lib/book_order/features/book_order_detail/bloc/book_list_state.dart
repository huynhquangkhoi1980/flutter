import 'package:equatable/equatable.dart';

import '../../../models/book.dart';

abstract class BookListState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  BookListState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnBookListState extends BookListState {
  UnBookListState();

  @override
  String toString() => 'UnBookListState';
}

/// Initialized
class InBookListState extends BookListState {
  InBookListState();

  @override
  String toString() => 'InBookListState';
}

class LoadingBookListState extends BookListState {
  LoadingBookListState();

  @override
  String toString() => 'LoadingBookListState';
}

// ignore: must_be_immutable
class SearchBookListState extends BookListState {
  List<Book> books;
  SearchBookListState(this.books);

  @override
  String toString() => 'SearchBookListState';
}

class ErrorBookListState extends BookListState {
  final String errorMessage;

  ErrorBookListState(this.errorMessage);

  @override
  String toString() => 'ErrorBookListState';

  @override
  List<Object> get props => [errorMessage];
}
