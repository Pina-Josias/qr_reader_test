import 'package:flutter/material.dart';
import 'package:qr_reader_test/main/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(makeMainPage());
}
