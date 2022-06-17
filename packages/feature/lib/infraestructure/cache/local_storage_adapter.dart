import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_feature/data/cache/cache.dart';

/// `LocalStorageAdapter` is a concrete implementation of [CacheStorage]
class LocalStorageAdapter implements CacheStorage {
  /// Creates instance of [LocalStorageAdapter]
  LocalStorageAdapter({FlutterSecureStorage? storage})
      : assert(
          storage != null,
          'Cannot create LocalStorageAdapter without storage',
        ),
        _storage = storage!;
  final FlutterSecureStorage _storage;

  @override
  Future<void> save({required String key, required String value}) async {
    await _storage.delete(key: key);
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<String?> fetch(String key) async {
    return _storage.read(key: key);
  }
}
