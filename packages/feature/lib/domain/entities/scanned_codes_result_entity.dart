import 'package:equatable/equatable.dart';
import 'package:qr_code_feature/domain/entities/scanned_code.dart';

/// The result of a load operation.
class ScannedCodesResultEntity extends Equatable {
  /// Creates an instance of [ScannedCodesResultEntity].
  const ScannedCodesResultEntity({
    required this.codes,
  });

  /// The list of scanned codes.
  final List<ScannedCodeEntity> codes;

  @override
  List<Object> get props => [codes];
}
