/// Cache Exception
class CacheException implements Exception {
  /// Creates instance of [CacheException]
  const CacheException({this.message});

  /// Message of exception
  final String? message;
}
