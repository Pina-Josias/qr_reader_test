import 'package:flutter/material.dart';

/// Allow to user to navigate between pages
Future<dynamic> navigate(BuildContext context, String route) async {
  final _response = await Navigator.pushNamed(context, route);
  return _response;
}
