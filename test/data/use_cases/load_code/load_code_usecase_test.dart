import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/data/cache/cache.dart';
import 'package:qr_code_feature/data/usecases/local_scanned_codes.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';

import '../../../mocks/fake_codes_factory.dart';

class CacheStorageMock extends Mock implements CacheStorage {}

void main() {
  late CacheStorageMock _storage;
  late DataLocalScannedCodes _sut;
  late String? _jsonValidData;
  late String? _jsonInvalidData;
  late String? _jsonIncompleteData;
  late ScannedCodesResultEntity _scannedCodesResultEntity;
  setUp(() {
    _storage = CacheStorageMock();
    _sut = DataLocalScannedCodes(storage: _storage);
    _scannedCodesResultEntity = FakeCodesFactory.makeEntity();
    _jsonValidData = FakeCodesFactory.makeValidJsonString();
    _jsonInvalidData = FakeCodesFactory.makeInvalidJsonString();
    _jsonIncompleteData = FakeCodesFactory.makeIncompleteJsonString();
  });

  test('Should the storage load all codes from cache', () async {
    // arrange
    when(() => _storage.fetch(any())).thenAnswer(
      (_) => Future.value(_jsonValidData),
    );

    // act

    final _data = await _sut.load();

    // assert
    verify(() => _storage.fetch(any())).called(1);
    expect(_data, isNotNull);
    expect(_data, isA<ScannedCodesResultEntity>());
    expect(_data.codes, isNotEmpty);
    expect(_data.codes, isA<List<ScannedCodeEntity>>());
    expect(_data.codes.length, equals(_scannedCodesResultEntity.codes.length));
  });

  test(
      'Should not the storage codes, returns'
      ' Cache exception for data error input', () async {
    // arrange

    when(() => _storage.fetch(any())).thenAnswer((invocation) => Future.value(
          _jsonInvalidData,
        ));

    // act

    final _future = _sut.load();

    // assert
    expect(_future, throwsA(const TypeMatcher<Exception>()));
  });

  test(
      'Should not the storage codes from list codes, returns'
      ' Cache exception for data error input', () async {
    // arrange

    when(() => _storage.fetch(any())).thenAnswer((invocation) => Future.value(
          _jsonIncompleteData,
        ));

    // act

    final _future = _sut.load();

    // assert
    expect(_future, throwsA(const TypeMatcher<Exception>()));
  });
}
