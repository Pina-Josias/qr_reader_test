import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_feature/infraestructure/cache/local_storage_adapter.dart';

import '../../mocks/faker_instance_factory.dart';

class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalStorageAdapter _sut;
  late FlutterSecureStorageMock _localStorage;
  late String _key;
  late String _value;

  setUp(() {
    _key = faker().randomGenerator.string(5);
    _value = faker().randomGenerator.string(50);
    _localStorage = FlutterSecureStorageMock();
    _sut = LocalStorageAdapter(storage: _localStorage);
  });

  group('save', () {
    test('Should call save with correct values', () async {
      when(
        () => _localStorage.delete(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        () => _localStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => Future.value());

      await _sut.save(key: _key, value: _value);

      verify(() => _localStorage.delete(key: _key)).called(1);
      verify(() => _localStorage.write(key: _key, value: _value)).called(1);
    });

    test(
      'Should throw if save error occours',
      () async {
        // arrange
        when(
          () => _localStorage.delete(
            key: any(named: 'key'),
          ),
        ).thenThrow(Exception());

        when(
          () => _localStorage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenThrow(Exception());

        // act
        final future = _sut.save(key: _key, value: _value);

        // assert
        expect(future, throwsA(const TypeMatcher<Exception>()));
      },
    );
  });

  group('fetch', () {
    test('Should call fetch  with correct value', () async {
      when(
        () => _localStorage.read(
          key: any(named: 'key'),
        ),
      ).thenAnswer((invocation) => Future.value(_value));

      await _sut.fetch(_key);

      verify(() => _localStorage.read(key: _key));
    });

    test('Should return correct value on success', () async {
      when(
        () => _localStorage.read(
          key: any(named: 'key'),
        ),
      ).thenAnswer((invocation) => Future.value(_value));

      final fetchedValue = await _sut.fetch(_key);

      expect(fetchedValue, _value);
    });

    test('Should throw if fetch secure throws', () async {
      when(
        () => _localStorage.read(
          key: any(named: 'key'),
        ),
      ).thenThrow(Exception());

      final future = _sut.fetch(_key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('delete', () {
    test('Should call delete with correct key', () async {
      when(
        () => _localStorage.delete(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => Future.value());

      await _sut.delete(_key);

      verify(() => _localStorage.delete(key: _key)).called(1);
    });

    test('Should throw if delete error occours', () async {
      when(
        () => _localStorage.delete(
          key: any(named: 'key'),
        ),
      ).thenThrow(Exception());

      final future = _sut.delete(_key);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });
}
