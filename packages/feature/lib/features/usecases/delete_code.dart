// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_feature/domain/entities/scanned_code.dart';
import 'package:qr_code_feature/features/contracts/contracts.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/helpers/helpers.dart';

/// [Use Case] to delete a `ScannedCode` from the database.
class DeleteCodeUseCase implements UseCase<void, ParamsDeleteCode> {
  /// Initialize [ILocalScannedCodesContract] extension to be used in providers
  DeleteCodeUseCase({required ILocalScannedCodesContract repository})
      : _repositoy = repository;

  final ILocalScannedCodesContract _repositoy;

  @override
  Future<Either<Failure, void>>? call(ParamsDeleteCode params) async =>
      _repositoy.delete(params._codes);
}

/// [ParamsDeleteCode] to delete a `ScannedCode` from the database.
class ParamsDeleteCode extends Equatable {
  /// Create instance of [ParamsDeleteCode]
  /// recieving a list of [ScannedCodeEntity]
  const ParamsDeleteCode({required List<ScannedCodeEntity> codes})
      : _codes = codes;

  final List<ScannedCodeEntity> _codes;

  @override
  List<Object> get props => [_codes];
}
