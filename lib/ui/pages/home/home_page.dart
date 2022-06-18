import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_reader_test/main/main.dart';
import 'package:qr_reader_test/presentation/extensions/extensions.dart';
import 'package:qr_reader_test/ui/components/components.dart';
import 'package:qr_reader_test/ui/pages/home/components/components.dart';
import 'package:qr_reader_test/ui/shared/shared.dart';

/// List of Qr&BarCodes on Home Page
class HomePage extends ConsumerStatefulWidget {
  /// Create an instance of HomePage
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(homePagePresenter).loadCodesFromUseCase();
    super.initState();
  }

  void onDeletedPressed(BuildContext context, ScannedCodeEntity code) {
    ref.read(homePagePresenter).deleteCodeToUseCase(code).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          onPressed: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          title: 'Deleted code with success!!',
        ),
      );
    });
  }

  void onSaveNewCodePressed(BuildContext context, ScannedCodeEntity code) {
    ref.read(homePagePresenter).saveCodeToUseCase(code).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          onPressed: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          title: 'Saved new code with success!!',
        ),
      );
    }).catchError((err) {
      ToastI().showToast(message: (err as CacheFailure).error.toString());
    });
  }

  Future<void> _navigateTo(BuildContext context) async {
    final _result = await navigate(context, Routes.qrBarRoute) as Barcode?;
    if (_result != null) {
      final _code = ScannedCodeEntity(
        code: _result.code!,
        codeType: describeEnum(_result.format).contains('qr')
            ? ScannedCodeType.qr
            : ScannedCodeType.barcode,
        dataType: _result.code!.isUrl()
            ? ScannedCodeDataType.url
            : ScannedCodeDataType.text,
      );
      if (!mounted) return;
      onSaveNewCodePressed(context, _code);
    }
  }

  Future<void> _checkPermission(BuildContext context, bool mounted) async {
    final canUseCamera = await requestPermission(Permission.camera);

    if (canUseCamera == false) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          actionTitle: 'Go to Settings',
          onPressed: () async {
            await openAppSettings();
          },
          title: 'Camera permission denied. Plese grant it.',
        ),
      );
      return;
    }
    if (!mounted) return;
    unawaited(_navigateTo(context));
  }

  @override
  Widget build(BuildContext context) {
    final _fetchingData =
        ref.watch(homePagePresenter.select((value) => value.loading));
    final _scannedCodes =
        ref.watch(homePagePresenter.select((value) => value.scannedCodes));

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR & Bar Code Scanner'),
      ),
      body: !_fetchingData
          ? ListCodesSeparated(
              scannedCodes: _scannedCodes,
              onDelete: (value) => onDeletedPressed(context, value),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: !_fetchingData
          ? FloatingActionButton(
              onPressed: () => _checkPermission(context, mounted),
              child: const Icon(
                Icons.qr_code_scanner,
              ),
            )
          : null,
    );
  }
}
