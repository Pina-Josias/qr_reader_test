// ignore_for_file: avoid_dynamic_calls

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/domain/repositories/local_scanned_codes_repo.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/helpers/helpers.dart';
import 'package:qr_code_feature/features/usecases/load_codes.dart';

import '../../../../mocks/fake_codes_factory.dart';

class LocalScannedCodesRepoMock extends Mock implements LocalScannedCodesRepo {}

void main() {
  late LoadCodesUseCase _sut;
  late LocalScannedCodesRepoMock _repo;
  late List<ScannedCodeEntity> _codes;
  late ScannedCodesResultEntity _resultCodes;
  setUp(() {
    _repo = LocalScannedCodesRepoMock();
    _sut = LoadCodesUseCase(repository: _repo);
    _resultCodes = FakeCodesFactory.makeEntity();
    _codes = _resultCodes.codes;
  });

  test('Shoul call Load Use Case, get all items from cache ', () async {
    // arrange
    when(() => _repo.load()).thenAnswer(
      (invocation) async => Future.value(Right(_resultCodes)),
    );
    // act
    dynamic _eval;
    final _result = await _sut.call(NoParams());

    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = success,
    );
    // assert
    verify(() => _repo.load()).called(1);
    expect(_eval is ScannedCodesResultEntity, true);
    expect(_eval.codes is List<ScannedCodeEntity>, true);
    expect(_eval.codes.length, _codes.length);
  });

  test('Should call Load Use Case, then return Failure ', () async {
    // arrange
    when(() => _repo.load()).thenAnswer(
      (invocation) async => Future.value(const Left(CacheFailure())),
    );
    // act
    dynamic _eval;
    final _result = await _sut.call(NoParams());

    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = success,
    );
    // assert
    verify(() => _repo.load()).called(1);
    expect(_eval is Failure, true);
  });
}
