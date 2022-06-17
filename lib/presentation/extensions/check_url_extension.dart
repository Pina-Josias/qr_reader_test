final _urlRegExp = RegExp(
  r'^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&\"\(\)\*\+,;=.]+$',
);

/// Format a number to a currency
extension IsUrl on String {
  /// Format a number to a currency extended
  bool isUrl() {
    return _urlRegExp.hasMatch(this);
  }
}
