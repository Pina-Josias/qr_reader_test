import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';
import 'package:qr_code_feature/features/failures/cache_failure.dart';
import 'package:qr_code_feature/features/failures/failure.dart';
import 'package:qr_code_feature/features/usecases/use_cases.dart';
import 'package:qr_reader_test/presentation/presenters/home_notifier_presenter.dart';

import '../../mocks/fake_codes_factory.dart';

class DeleteCodeUseCaseMock extends Mock implements DeleteCodeUseCase {}

class LoadCodesUseCaseMock extends Mock implements LoadCodesUseCase {}

class SaveCodeUseCaseMock extends Mock implements SaveCodeUseCase {}

void main() {
  late DeleteCodeUseCaseMock _deleteCodeUseCase;
  late LoadCodesUseCaseMock _loadCodesUseCase;
  late SaveCodeUseCaseMock _saveCodeUseCase;
  late HomeNotifierPresenter _sut;
  late ScannedCodesResultEntity _scannedCodes;
  setUp(() {
    _deleteCodeUseCase = DeleteCodeUseCaseMock();
    _loadCodesUseCase = LoadCodesUseCaseMock();
    _saveCodeUseCase = SaveCodeUseCaseMock();
    _scannedCodes = FakeCodesFactory.makeEntity();
    _sut = HomeNotifierPresenter(
      deleteCode: _deleteCodeUseCase,
      loadCodes: _loadCodesUseCase,
      saveCode: _saveCodeUseCase,
    );
    registerFallbackValue(const ParamsSaveCode(codes: []));
    registerFallbackValue(const ParamsDeleteCode(codes: []));
  });

  group('Load data ', () {
    test('Should the presenter returns a correct List of Codes', () async {
      // arrange
      when(() => _loadCodesUseCase(any()))
          .thenAnswer((invocation) => Future.value(Right(_scannedCodes)));
      // act
      await _sut.loadCodesFromUseCase();
      // assert
      expect(_sut.scannedCodes, _scannedCodes.codes);
      expect(_sut.loading, false);
    });

    test('Should the presenter returns a Failure on Loading Data', () async {
      // arrange
      when(() => _loadCodesUseCase(any())).thenAnswer((invocation) =>
          Future.value(const Left(CacheFailure(error: 'Error'))));

      // act
      dynamic _eval;

      await _sut.loadCodesFromUseCase().catchError((e) {
        _eval = e;
      });

      // assert
      expect(_eval is Failure, true);
      expect(_sut.loading, false);
    });
  });
  group('Save Data ', () {
    test('Should the presenter save codes with success', () async {
      // arrange

      when(() => _saveCodeUseCase(any()))
          .thenAnswer((invocation) async => Future.value(const Right(null)));
      // act

      const _newCode = ScannedCodeEntity(
        code: '123456789AAAAA',
        codeType: ScannedCodeType.barcode,
        dataType: ScannedCodeDataType.text,
      );
      await _sut.saveCodeToUseCase(_newCode);
      // assert
      expect(_sut.scannedCodes, [_newCode]);
      expect(_sut.loading, false);
    });

    test(
        'Should the presenter returns a Failure '
        'on Saving Data for Duplicated', () async {
      // arrange
      when(() => _loadCodesUseCase(any()))
          .thenAnswer((invocation) => Future.value(Right(_scannedCodes)));
      when(() => _saveCodeUseCase(any()))
          .thenAnswer((invocation) => Future.value(const Right(null)));

      // act
      await _sut.loadCodesFromUseCase();
      dynamic _eval;
      final _newCode = _sut.scannedCodes.first;
      await _sut.saveCodeToUseCase(_newCode).catchError((e) {
        _eval = e;
      });

      // assert
      expect(_eval is Failure, true);
      expect(_sut.loading, false);
    });
  });

  group('Delete data ', () {
    test('Should the presenter erase one code stored on cache', () async {
      // arrange
      when(() => _loadCodesUseCase(any()))
          .thenAnswer((invocation) => Future.value(Right(_scannedCodes)));
      when(() => _deleteCodeUseCase(any()))
          .thenAnswer((invocation) => Future.value(const Right(null)));
      // act
      await _sut.loadCodesFromUseCase();
      await _sut.deleteCodeToUseCase(_sut.scannedCodes.first);
      // assert
      expect(_sut.scannedCodes, _scannedCodes.codes.skip(1).toList());
      expect(_sut.loading, false);
    });

    test('Should the presenter returns a Failure on Loading Data', () async {
      // arrange
      when(() => _loadCodesUseCase(any()))
          .thenAnswer((invocation) => Future.value(Right(_scannedCodes)));
      when(() => _deleteCodeUseCase(any())).thenAnswer((invocation) =>
          Future.value(const Left(CacheFailure(error: 'Error'))));

      // act
      await _sut.loadCodesFromUseCase();

      dynamic _eval;

      await _sut.deleteCodeToUseCase(_sut.scannedCodes.first).catchError((e) {
        _eval = e;
      });

      // assert
      expect(_eval is Failure, true);
      expect(_sut.loading, false);
    });
  });
}
