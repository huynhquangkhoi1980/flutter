import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';

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
      alignment: Alignment.center,
      color: AppColors.bodyMainColor,
      child: child,
    );
  }
}
