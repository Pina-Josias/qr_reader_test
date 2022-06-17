import 'package:qr_code_feature/domain/entities/entities.dart';

/// Intance of [LocalScannedCodeModel] to convert a [ScannedCodeEntity]
/// to a [LocalScannedCodeModel] and vice versa.
class LocalScannedCodeModel {
  /// Creates a new instance of [LocalScannedCodeModel].
  const LocalScannedCodeModel({
    required this.code,
    required this.dataType,
    required this.codeType,
  });

  /// Create an instance of [LocalScannedCodeModel] from a [Map]
  factory LocalScannedCodeModel.fromJson(Map<String, dynamic> json) {
    if (!json.keys.toSet().containsAll(['code', 'dataType', 'codeType'])) {
      throw Exception('Error with json model for LocalScannedCodeModel');
    }
    return LocalScannedCodeModel(
      code: json['code'].toString(),
      dataType: ScannedCodeDataType.values
          .firstWhere((e) => e.toString() == json['dataType']),
      codeType: ScannedCodeType.values
          .firstWhere((e) => e.toString() == json['codeType']),
    );
  }

  /// Create an instance of [ScannedCodeEntity]
  /// from this [LocalScannedCodeModel]
  factory LocalScannedCodeModel.fromEntity(ScannedCodeEntity entity) =>
      LocalScannedCodeModel(
        code: entity.code,
        dataType: entity.dataType,
        codeType: entity.codeType,
      );

  /// Code of the scanned code
  final String code;

  /// Data type of the scanned code
  final ScannedCodeDataType dataType;

  /// Code type of the scanned code
  final ScannedCodeType codeType;

  /// Convert this [LocalScannedCodeModel] to a [ScannedCodeEntity]
  ScannedCodeEntity toEntity() => ScannedCodeEntity(
        code: code,
        dataType: dataType,
        codeType: codeType,
      );

  /// Convert this [LocalScannedCodeModel] to a [Map]
  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'dataType': dataType.toString(),
        'codeType': codeType.toString(),
      };
}
