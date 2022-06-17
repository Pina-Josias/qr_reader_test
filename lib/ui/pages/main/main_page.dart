import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_reader_test/ui/components/components.dart';
import 'package:qr_reader_test/ui/shared/routes.dart';

/// Main Class for the App
class MyApp extends StatelessWidget {
  /// Create an instance of the App Widget
  MyApp({super.key}) : _router = AppRouter();

  final AppRouter _router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Qr & Bar Code Reader',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _router.getRoute,
        initialRoute: Routes.homeRoute,
        navigatorObservers: [_router.routeObserver],
      ),
    );
  }
}
