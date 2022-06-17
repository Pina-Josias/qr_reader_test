// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/features/contracts/contracts.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/helpers/helpers.dart';

/// [Use Case] to load all `ScannedCode` from the database.
class LoadCodesUseCase implements UseCase<ScannedCodesResultEntity, NoParams?> {
  /// Initialize [ILocalScannedCodesContract] extension to be used in providers
  LoadCodesUseCase({required ILocalScannedCodesContract repository})
      : _repositoy = repository;

  final ILocalScannedCodesContract _repositoy;

  @override
  Future<Either<Failure, ScannedCodesResultEntity>>? call(
    NoParams? params,
  ) async =>
      _repositoy.load();
}
