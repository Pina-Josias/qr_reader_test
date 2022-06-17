import 'package:equatable/equatable.dart';

/// Enum to represent the different data types of  [ScannedCodeEntity].
enum ScannedCodeDataType {
  /// The data type is a simple [String].
  text,

  /// The data type is a `Phone Number` .
  phone,

  /// The data type is a `Email Address`.
  email,

  /// The data type is a `URL`.
  url,
}

/// Enum to represent the different code types of  [ScannedCodeEntity].
enum ScannedCodeType {
  /// The code type is a `QR Code`.
  qr,

  /// The code type is a `Bar Code`.
  barcode,
}

/// Entity to represent a scanned code.
class ScannedCodeEntity extends Equatable {
  /// Creates a new instance of [ScannedCodeEntity].
  const ScannedCodeEntity({
    required this.code,
    required this.dataType,
    required this.codeType,
  });

  /// Code of the scanned code.
  final String code;

  /// Data type of the scanned code.
  final ScannedCodeDataType dataType;

  /// Code type of the scanned code.
  final ScannedCodeType codeType;

  @override
  List<Object> get props => [code, dataType, codeType];
}
