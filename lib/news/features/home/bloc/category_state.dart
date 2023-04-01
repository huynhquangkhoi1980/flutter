// ignore_for_file: avoid_positional_boolean_parameters

import 'package:equatable/equatable.dart';
import 'package:mevn_app/news/models/category_res.dart';

abstract class CategoryState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CategoryState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnCategoryState extends CategoryState {
  UnCategoryState();

  @override
  String toString() => 'UnCategoryState';
}

/// Initialized
class InCategoryState extends CategoryState {
  InCategoryState();

  @override
  String toString() => 'InCategoryState';
}

class LoadingState extends CategoryState {
  LoadingState();

  @override
  String toString() => 'LoadingState';
}

class CategoryLoadedState extends CategoryState {
  final CategoryRes data;
  CategoryLoadedState(this.data);

  @override
  String toString() => 'CategoryLoadedState';
}

class ErrorCategoryState extends CategoryState {
  ErrorCategoryState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorCategoryState';

  @override
  List<Object> get props => [errorMessage];
}
