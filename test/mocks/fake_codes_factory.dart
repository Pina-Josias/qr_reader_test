import 'package:qr_code_feature/domain/entities/entities.dart';

import 'faker_instance_factory.dart';

class FakeCodesFactory {
  static Map<String, dynamic> makeCacheJson() => {
        'codes': [
          {
            'code': faker().internet.httpUrl(),
            'dataType': ScannedCodeDataType.url.toString(),
            'codeType': ScannedCodeType.qr.toString(),
          },
          {
            'code': faker().internet.httpsUrl(),
            'dataType': ScannedCodeDataType.url.toString(),
            'codeType': ScannedCodeType.qr.toString(),
          },
          {
            'code': faker().guid.guid(),
            'dataType': ScannedCodeDataType.text.toString(),
            'codeType': ScannedCodeType.barcode.toString(),
          },
        ],
      };

  static Map<String, dynamic> makeInvalidCacheJson() => {
        'codes': [
          {
            'code': faker().internet.httpUrl(),
            'dataType': ScannedCodeDataType.url,
            'codeType': ScannedCodeType.qr,
          }
        ],
      };
  static Map<String, dynamic> makeIncompleteCacheJson() => {};

  static ScannedCodesResultEntity makeEntity() => ScannedCodesResultEntity(
        codes: [
          ScannedCodeEntity(
            code: faker().internet.httpUrl(),
            dataType: ScannedCodeDataType.url,
            codeType: ScannedCodeType.qr,
          ),
          ScannedCodeEntity(
            code: faker().internet.httpsUrl(),
            dataType: ScannedCodeDataType.url,
            codeType: ScannedCodeType.qr,
          ),
          ScannedCodeEntity(
            code: faker().guid.guid(),
            dataType: ScannedCodeDataType.text,
            codeType: ScannedCodeType.barcode,
          ),
        ],
      );
}
