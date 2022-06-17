/// Repository Inteface to manage common cache functions.
abstract class CacheStorage {
  /// Gets the value of the specified key.
  Future<String?> fetch(String key);

  /// Delete the value of the specified key.
  Future<void> delete(String key);

  /// Saves the value of the specified key.
  Future<void> save({required String key, required String value});
}
