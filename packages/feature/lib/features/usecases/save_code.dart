// ignore_for_file: one_member_abstracts

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_feature/domain/entities/scanned_code.dart';
import 'package:qr_code_feature/features/contracts/contracts.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/helpers/helpers.dart';

/// [Use Case] to save a `ScannedCode` from the database.
class SaveCodeUseCase implements UseCase<void, ParamsSaveCode> {
  /// Initialize [ILocalScannedCodesContract] extension to be used in providers
  SaveCodeUseCase({required ILocalScannedCodesContract repository})
      : _repositoy = repository;

  final ILocalScannedCodesContract _repositoy;

  @override
  Future<Either<Failure, void>>? call(ParamsSaveCode params) async =>
      _repositoy.save(params._codes);
}

/// [ParamsSaveCode] to save a `ScannedCodes` from to database.
class ParamsSaveCode extends Equatable {
  /// Create instance of [ParamsSaveCode]
  /// recieving a list of [ScannedCodeEntity]
  const ParamsSaveCode({required List<ScannedCodeEntity> codes})
      : _codes = codes;

  final List<ScannedCodeEntity> _codes;

  @override
  List<Object> get props => [_codes];
}
