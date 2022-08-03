import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    required this.message,
  });

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> show(
    BuildContext context,
    String message,
    String type,
  ) async {
    Color? backgroundColor;
    switch (type) {
      case 'danger':
        backgroundColor = Colors.red;
        break;
      case 'success':
        backgroundColor = Colors.green;
        break;
      case 'info':
        backgroundColor = Colors.blue;
        break;
      case 'warning':
        backgroundColor = Colors.yellow;
        break;
      default:
        backgroundColor = Colors.green;
        break;
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: const Duration(milliseconds: 2500),
      ),
    );
  }
}
