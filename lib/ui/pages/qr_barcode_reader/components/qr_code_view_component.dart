import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// Component for display camera for qr code scanner
class QRCodeComponent extends StatelessWidget {
  /// Create an instance of QRCodeComponent
  const QRCodeComponent({
    super.key,
    required this.qrKey,
    this.scanArea = 200,
    required this.onQRViewCreated,
  });

  /// QR key
  final GlobalKey qrKey;

  /// [scanArea] is the size of the area where the QR code is scanned.
  final double scanArea;

  /// [onQRViewCreated] is the callback function
  /// when the QR code scanner is created.
  final void Function(QRViewController) onQRViewCreated;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
        borderColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
