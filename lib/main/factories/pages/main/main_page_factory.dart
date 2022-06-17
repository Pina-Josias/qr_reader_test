import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_reader_test/ui/pages/main/main_page.dart';

/// Initial page of the app, initialize the providers for all `Pages`
Widget makeMainPage() => ProviderScope(child: MyApp());
