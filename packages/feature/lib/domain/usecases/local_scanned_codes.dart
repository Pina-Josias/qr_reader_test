// ignore_for_file: one_member_abstracts

import 'package:qr_code_feature/domain/entities/entities.dart';

/// Operations of [ILocalScannedCodes] Use Case class.
abstract class ILocalScannedCodes {
  /// Loads the list of codes from the database.
  Future<ScannedCodesResultEntity> load();

  /// Delete a `ScannedCode` from the database.
  Future<void> delete(List<ScannedCodeEntity> codes);

  /// Saves the list of codes to the cache.
  Future<void> save(List<ScannedCodeEntity> codes);
}
