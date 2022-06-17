import 'package:either_dart/either.dart';
import 'package:qr_code_feature/data/exeptions/cache_exeption.dart';
import 'package:qr_code_feature/domain/entities/scanned_code.dart';
import 'package:qr_code_feature/domain/entities/scanned_codes_result_entity.dart';
import 'package:qr_code_feature/domain/helpers/helpers.dart';
import 'package:qr_code_feature/domain/usecases/use_cases.dart';
import 'package:qr_code_feature/features/contracts/contracts.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/failures/failure.dart';

/// Implementation of [ILocalScannedCodesContract] Use Case class for Contracts.
class LocalScannedCodesRepo implements ILocalScannedCodesContract {
  /// Initialize [LocalScannedCodesRepo]
  /// to call [ILocalScannedCodesContract] methods
  LocalScannedCodesRepo({
    required ILocalScannedCodes local,
  }) : _local = local;

  final ILocalScannedCodes _local;
  @override
  Future<Either<Failure, void>> delete(List<ScannedCodeEntity> codes) async {
    try {
      await _local.delete(codes);
      return const Right(null);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          error: error.message,
          domainError: DataDomainError.unexpected,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ScannedCodesResultEntity>> load() async {
    try {
      final _response = await _local.load();
      return Right(_response);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          error: error.message,
          domainError: DataDomainError.notFound,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> save(List<ScannedCodeEntity> codes) async {
    try {
      await _local.save(codes);
      return const Right(null);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          error: error.message,
          domainError: DataDomainError.unsaved,
        ),
      );
    }
  }
}
