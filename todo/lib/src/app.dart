import 'package:flutter/material.dart';
import 'package:todo/src/blocs/auth_bloc.dart';
class MyApp extends InheritedWidget {

  final AuthBloc authBloc;
  @override
  // ignore: overridden_fields
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const MyApp(this.authBloc, this.child) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static MyApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyApp>();
  }
}
