import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_reader_test/ui/components/components.dart';
import 'package:qr_reader_test/ui/shared/url_launcher.dart';

const _empty = <ScannedCodeEntity>[];

/// List of Qr&BarCodes on Home Page
class ListCodesSeparated extends StatelessWidget {
  /// Create an instance of ListCodesSeparated
  const ListCodesSeparated({
    super.key,
    List<ScannedCodeEntity> scannedCodes = _empty,
    void Function(ScannedCodeEntity)? onDelete,
  })  : _scannedCodes = scannedCodes,
        _onDelete = onDelete;

  final List<ScannedCodeEntity> _scannedCodes;
  final void Function(ScannedCodeEntity)? _onDelete;

  @override
  Widget build(BuildContext context) {
    if (_scannedCodes.isEmpty) {
      return const Center(
        child: Text('No codes yet'),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) => ListTile(
        leading: FloatingActionButton.small(
          heroTag: 'key$index',
          backgroundColor: Colors.red.shade100,
          child: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            if (_onDelete != null) _onDelete!.call(_scannedCodes[index]);
          },
        ),
        title: Text(
          'CodeType: '
          '${describeEnum(_scannedCodes[index].codeType).toUpperCase()}',
        ),
        subtitle: Text(
          ' ${_scannedCodes[index].code}',
          style: _scannedCodes[index].dataType == ScannedCodeDataType.url
              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  )
              : Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: _scannedCodes[index].dataType == ScannedCodeDataType.url
            ? IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  launchUrlPath(_scannedCodes[index].code);
                },
              )
            : null,
        onTap: () {
          Clipboard.setData(ClipboardData(text: _scannedCodes[index].code))
              .then((value) {
            ToastI().showToast(message: 'Copied to clipboard');
          });
        },
      ),
      itemCount: _scannedCodes.length,
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
