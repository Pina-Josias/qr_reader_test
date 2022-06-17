// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/features/failures/failure.dart';

/// Operations of [ILocalScannedCodesContract] Use Case class,
/// returns a failure on error.
abstract class ILocalScannedCodesContract {
  /// Loads the list of codes from the database.
  Future<Either<Failure, ScannedCodesResultEntity>> load();

  /// Delete a `ScannedCode` from the database.
  Future<Either<Failure, void>> delete(List<ScannedCodeEntity> codes);

  /// Saves the list of codes to the cache.
  Future<Either<Failure, void>> save(List<ScannedCodeEntity> codes);
}
