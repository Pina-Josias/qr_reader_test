import 'package:flutter/material.dart';

/// Create a toast Widget with the given parameters
class Toast extends StatelessWidget {
  /// Create an instance of Toast
  const Toast({
    super.key,
    Color color = Colors.black54,
    Color textColor = Colors.white,
    String message = 'Alert Toast',
    IconData icon = Icons.info,
  })  : _color = color,
        _textColor = textColor,
        _message = message,
        _icon = icon;

  final Color _color;
  final Color _textColor;
  final String _message;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    _icon,
                    size: 15,
                    color: _textColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    _message,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
