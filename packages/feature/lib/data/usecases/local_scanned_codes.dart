import 'dart:convert';

import 'package:qr_code_feature/data/cache/cache.dart';
import 'package:qr_code_feature/data/exeptions/cache_exeption.dart';
import 'package:qr_code_feature/data/models/local_scanned_codes_result_model.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/domain/usecases/local_scanned_codes.dart';

/// `Use Case` for deleting scanned codes from cache
class DataLocalScannedCodes implements ILocalScannedCodes {
  /// Creates instance of [DataLocalScannedCodes]
  const DataLocalScannedCodes({
    required CacheStorage storage,
  }) : _storage = storage;

  final CacheStorage _storage;

  @override
  Future<void> delete(List<ScannedCodeEntity> codes) async {
    try {
      final _dtoCodes = LocalScannedCodesModel.fromEntity(
        ScannedCodesResultEntity(codes: codes),
      );
      await _storage.save(
        key: 'scanned_codes',
        value: json.encode(_dtoCodes.toJson()),
      );
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  @override
  Future<ScannedCodesResultEntity> load() async {
    try {
      final _cachedData = await _storage.fetch(
        'scanned_codes',
      );

      if (_cachedData == null) {
        return const ScannedCodesResultEntity(codes: []);
      }

      final _dataMapped = LocalScannedCodesModel.fromRawJson(_cachedData);

      return _dataMapped.toEntity();
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> save(List<ScannedCodeEntity> codes) async {
    try {
      final _dtoCodes = LocalScannedCodesModel.fromEntity(
        ScannedCodesResultEntity(codes: codes),
      );
      await _storage.save(
        key: 'scanned_codes',
        value: _dtoCodes.toRawJson(),
      );
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
