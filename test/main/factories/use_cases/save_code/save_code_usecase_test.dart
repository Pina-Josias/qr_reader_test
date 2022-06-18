import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/domain/repositories/local_scanned_codes_repo.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/usecases/save_code.dart';

import '../../../../mocks/fake_codes_factory.dart';

class LocalScannedCodesRepoMock extends Mock implements LocalScannedCodesRepo {}

void main() {
  late SaveCodeUseCase _sut;
  late LocalScannedCodesRepoMock _repo;
  late List<ScannedCodeEntity> _codes;
  setUp(() {
    _repo = LocalScannedCodesRepoMock();
    _sut = SaveCodeUseCase(repository: _repo);
    _codes = FakeCodesFactory.makeEntity().codes;
  });

  test('Should call Save Use Case, then save item to cache ', () async {
    // arrange
    when(() => _repo.save(any())).thenAnswer(
      (invocation) async => Future.value(const Right(null)),
    );
    // act
    dynamic _eval;
    final _params = ParamsSaveCode(codes: _codes);
    final _result = await _sut.call(_params);
    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = null,
    );
    // assert
    verify(() => _repo.save(_codes)).called(1);
    expect(_eval, isNull);
  });
  test('Should call Save Use Case, then return Failure ', () async {
    // arrange
    when(() => _repo.save(any())).thenAnswer(
      (invocation) async => Future.value(const Left(CacheFailure())),
    );
    // act
    dynamic _eval;
    final _params = ParamsSaveCode(codes: _codes);
    final _result = await _sut.call(_params);

    _result?.fold(
      (failure) => _eval = failure,
      (success) => _eval = null,
    );

    // assert
    verify(() => _repo.save(_codes)).called(1);
    expect(_eval is Failure, true);
  });
}
