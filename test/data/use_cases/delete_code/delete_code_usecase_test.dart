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

  test('Should the storage delete current entity from cache', () async {
    final _expect = _codes.skip(0).toList();

    // arrange
    when(() => _storage.save(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenAnswer(
      (_) => Future.value(),
    );

    // act

    await _sut.delete(_expect);

    // assert
    verify(() => _storage.save(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).called(1);
  });

  test('Should the storage delete, returns Cache exception', () async {
    final _expect = _codes.skip(0).toList();

    // arrange
    when(() => _storage.save(
          key: any(named: 'key'),
          value: any(named: 'value'),
        )).thenThrow(const CacheException());

    // act

    final _future = _sut.delete(_expect);

    // assert
    expect(_future, throwsA(const TypeMatcher<Exception>()));
  });
}
