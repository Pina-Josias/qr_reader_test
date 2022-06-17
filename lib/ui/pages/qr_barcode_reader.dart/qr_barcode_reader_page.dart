import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_reader_test/presentation/extensions/extensions.dart';
import 'package:qr_reader_test/ui/components/components.dart';
import 'package:qr_reader_test/ui/pages/qr_barcode_reader.dart/components/components.dart';

/// Qr&BarCode reader page
class QrBarcodeReader extends StatefulWidget {
  /// Create an instance of QrBarcodeReader
  const QrBarcodeReader({super.key});

  @override
  State<QrBarcodeReader> createState() => _QrBarcodeReaderState();
}

class _QrBarcodeReaderState extends State<QrBarcodeReader> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scanArea = MediaQuery.of(context).size.shortestSide * .75;
    //describeEnum(result!.format);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Barcode Reader'),
      ),
      body: Stack(
        children: [
          QRCodeComponent(
            qrKey: qrKey,
            scanArea: _scanArea,
            onQRViewCreated: _onQRViewCreated,
          ),
          OrientationBuilder(
            builder: (context, Orientation orientation) {
              final _paddingBotton =
                  orientation == Orientation.portrait ? 50.0 : 0.0;
              final _paddingRight =
                  orientation == Orientation.landscape ? 20.0 : 0.0;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: _paddingBotton,
                  right: _paddingRight,
                ),
                child: Align(
                  alignment: orientation == Orientation.portrait
                      ? Alignment.bottomCenter
                      : Alignment.centerRight,
                  child: IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                    },
                    icon: FutureBuilder(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return const Icon(Icons.flash_on);
                        }
                        return const Icon(Icons.flash_off);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    await controller.resumeCamera();
    _listentToQrCode();
  }

  void _listentToQrCode() {
    controller?.scannedDataStream.listen((scanData) async {
      await controller?.pauseCamera();
      final _response = await showDialog<bool>(
        context: context,
        builder: (_) => customDialogCode(
          context,
          data: scanData.code ?? '',
          isUrl: !scanData.code.isNullOrEmpty() && scanData.code!.isUrl(),
        ),
      );
      if (_response == true) {
        if (mounted) Navigator.pop(context, scanData);
      }
      await controller?.resumeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
