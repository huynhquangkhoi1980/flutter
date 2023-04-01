import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/src/base/base_event.dart';

abstract class BaseBloc {
  final StreamController<BaseEvent> _evenStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _evenStreamController.sink;

  // Constractor for BaseBloc:
  BaseBloc() {
    _evenStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Event is inappropriate!");
      }

      dispatchEvent(event);
    });
  }

  void dispatchEvent(BaseEvent event);

  // Annotation @mustCallSupper let the child class auto call this method
  @mustCallSuper
  void dispose() {
    _evenStreamController.close();
  }
}
