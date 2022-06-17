import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_feature/infraestructure/cache/cache.dart';

/// Create an adapter of LocalStorage to access to storaged data
LocalStorageAdapter makeCacheAdapter() =>
    LocalStorageAdapter(storage: const FlutterSecureStorage());
