import 'package:flutter/material.dart';
import 'package:qr_reader_test/ui/shared/shared.dart';

/// Creates a custom snackbar
AlertDialog customDialogCode(
  BuildContext context, {
  String title = 'QR Scanner Result',
  String data = 'Action',
  bool isUrl = false,
}) =>
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              text: 'Data: ',
              children: [
                TextSpan(
                  text: data,
                  style: isUrl
                      ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          )
                      : Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        if (isUrl)
          TextButton(
            onPressed: () {
              launchUrlPath(data);
            },
            child: const Text('Open'),
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Save'),
        ),
      ],
    );
