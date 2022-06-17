import 'package:flutter/material.dart';

/// Creates a custom snackbar
SnackBar customSnackBar({
  String title = 'Title',
  String actionTitle = 'Ok',
  VoidCallback? onPressed,
}) =>
    SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: actionTitle,
        onPressed: onPressed ?? () {},
      ),
    );
