import 'package:flutter/material.dart';

customSnackBar(
    {required message,
    Color color = Colors.white,
    required BuildContext context}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
  ));
}
