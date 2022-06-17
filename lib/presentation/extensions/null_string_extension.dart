/// Format a number to a currency
extension IsNullOrEmpty on String? {
  /// Format a number to a currency extended
  bool isNullOrEmpty() {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    return false;
  }
}
