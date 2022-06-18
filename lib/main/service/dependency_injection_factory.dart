import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_reader_test/main/main.dart';

/// This is our global ServiceLocator
final _it = GetIt.instance;

/// Init All dependencies
Future<void> init() async {
  /// `GLOBAL INSTANCES `
  const _storage = FlutterSecureStorage();

  _it
    ..registerSingleton<FlutterSecureStorage>(_storage)
    ..registerLazySingleton(makeCacheAdapter)
    ..registerLazySingleton(makeDataLocalScannedCodes)
    ..registerLazySingleton(makeLocalScannedCodesRepo)
    ..registerLazySingleton(makeDeleteCodeUseCase)
    ..registerLazySingleton(makeLoadCodesUseCase)
    ..registerLazySingleton(makeSaveCodeUseCase);
}
