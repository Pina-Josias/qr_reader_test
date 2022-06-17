import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_reader_test/ui/pages/home/home.dart';
import 'package:qr_reader_test/ui/pages/qr_barcode_reader.dart/qr_barcode_reader.dart';
import 'package:qr_reader_test/ui/shared/shared.dart';

/// Class for magage navigation page on the application
class AppRouter {
  /// Constructor of router. Initialize the route Observer
  AppRouter() : routeObserver = RouteObserver<PageRoute<dynamic>>();

  /// Declare route observer for navigator app
  final RouteObserver<PageRoute<dynamic>> routeObserver;

  /// Create a Route by the current page called by a non named Navigator
  Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {

      /// [Hub module]
      case Routes.homeRoute:
        return _buildRoute(
          settings,
          const HomePage(),
        );
      case Routes.qrBarRoute:
        return _buildRoute(
          settings,
          const QrBarcodeReader(),
          fullscreenDialog: true,
        );

      /// [Not found page]
      default:
        return _buildRoute(
          settings,
          const Scaffold(
            body: Center(child: Text('Not Found')),
          ),
        );
    }
  }

  PageTransition<dynamic> _buildRoute(
    RouteSettings settings,
    Widget child, {
    bool fullscreenDialog = false,
  }) {
    return PageTransition<dynamic>(
      type: !fullscreenDialog
          ? PageTransitionType.rightToLeft
          : PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 250),
      child: child,
      curve: Curves.easeInOut,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
