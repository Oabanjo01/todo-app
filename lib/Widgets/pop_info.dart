import 'package:flutter/material.dart';

class PopScaffold {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ));
  }
}
