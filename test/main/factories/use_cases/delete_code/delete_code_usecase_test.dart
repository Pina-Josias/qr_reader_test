import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/domain/repositories/local_scanned_codes_repo.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/usecases/delete_code.dart';

import '../../../../mocks/fake_codes_factory.dart';

class LocalScannedCodesRepoMock extends Mock implements LocalScannedCodesRepo {}

void main() {
  late DeleteCodeUseCase _sut;
  late LocalScannedCodesRepoMock _repo;
  late List<ScannedCodeEntity> _codes;
  setUp(() {
    _repo = LocalScannedCodesRepoMock();
    _sut = DeleteCodeUseCase(repository: _repo);
    _codes = FakeCodesFactory.makeEntity().codes;
  });

  test('Should call Delete Use Case remove item from cache ', () async {
    // arrange
    when(() => _repo.delete(any())).thenAnswer(
      (invocation) async => Future.value(const Right(null)),
    );
    // act
    dynamic _eval;
    final _params = ParamsDeleteCode(codes: _codes);
    final _result = await _sut.call(_params);
    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = null,
    );
    // assert
    verify(() => _repo.delete(_codes)).called(1);
    expect(_eval, isNull);
  });
  test('Should call Delete Use Case, then return Failure ', () async {
    // arrange
    when(() => _repo.delete(any())).thenAnswer(
      (invocation) async => Future.value(const Left(CacheFailure())),
    );
    // act
    dynamic _eval;
    final _params = ParamsDeleteCode(codes: _codes);
    final _result = await _sut.call(_params);

    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = null,
    );

    // assert
    verify(() => _repo.delete(_codes)).called(1);
    expect(_eval is Failure, true);
  });
}
