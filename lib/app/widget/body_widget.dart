import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key? key,
    this.context,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final BuildContext? context;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
