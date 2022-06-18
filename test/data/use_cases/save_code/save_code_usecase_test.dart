import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/data/cache/cache.dart';
import 'package:qr_code_feature/data/exeptions/cache_exeption.dart';
import 'package:qr_code_feature/data/usecases/local_scanned_codes.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';

import '../../../mocks/fake_codes_factory.dart';

class CacheStorageMock extends Mock implements CacheStorage {}

void main() {
  late CacheStorageMock _storage;
  late DataLocalScannedCodes _sut;
  late List<ScannedCodeEntity> _codes;
  setUp(() {
    _storage = CacheStorageMock();
    _sut = DataLocalScannedCodes(storage: _storage);
    _codes = FakeCodesFactory.makeEntity().codes;
  });

  test('Should the storage save current entity to cache', () async {
    // arrange
    when(() => _storage.save(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenAnswer(
      (_) => Future.value(),
    );

    // act

    await _sut.save(_codes);

    // assert
    verify(
      () => _storage.save(key: any(named: 'key'), value: any(named: 'value')),
    ).called(1);
  });

  test('Should the storage try save entity, returns Cache exception', () async {
    // arrange
    when(() => _storage.save(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenThrow(const CacheException());

    // act

    final _future = _sut.save(_codes);

    // assert
    expect(_future, throwsA(const TypeMatcher<Exception>()));
  });
}
