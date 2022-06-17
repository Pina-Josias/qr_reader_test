// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:qr_code_feature/data/models/local_scanned_code_model.dart';
import 'package:qr_code_feature/domain/entities/entities.dart';

/// Intance of [LocalScannedCodesModel] to convert a [ScannedCodesResultEntity]
/// to a [LocalScannedCodeModel] and vice versa.
class LocalScannedCodesModel {
  /// Create an instance of [LocalScannedCodesModel]
  const LocalScannedCodesModel({
    required this.codes,
  });

  /// Create an instance of [LocalScannedCodeModel] from [json] string
  factory LocalScannedCodesModel.fromRawJson(String str) =>
      LocalScannedCodesModel.fromJson(json.decode(str) as Map<String, dynamic>);

  /// Create an instance of [LocalScannedCodesModel] from [Map]
  factory LocalScannedCodesModel.fromJson(Map<String, dynamic> json) {
    if (!json.keys.toSet().containsAll(['codes'])) {
      throw Exception('Error with json model for LocalScannedCodesModel');
    }

    return LocalScannedCodesModel(
      codes: List<LocalScannedCodeModel>.from(
        json['codes'].map(
          (dynamic x) =>
              LocalScannedCodeModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// Create an instance of [LocalScannedCodesModel]
  /// from a [ScannedCodesResultEntity]
  factory LocalScannedCodesModel.fromEntity(ScannedCodesResultEntity entity) =>
      LocalScannedCodesModel(
        codes: entity.codes
            .map<LocalScannedCodeModel>(
              LocalScannedCodeModel.fromEntity,
            )
            .toList(),
      );

  /// List of [LocalScannedCodeModel]
  final List<LocalScannedCodeModel> codes;

  /// Convert this [LocalScannedCodesModel] to a [ScannedCodesResultEntity]
  ScannedCodesResultEntity toEntity() => ScannedCodesResultEntity(
        codes: codes.map((model) => model.toEntity()).toList(),
      );

  /// Convert this [LocalScannedCodesModel] Map to a Raw String
  String toRawJson() => json.encode(toJson());

  /// Convert this [LocalScannedCodesModel] to a [Map]
  Map<String, dynamic> toJson() => <String, dynamic>{
        'codes': List<dynamic>.from(codes.map<dynamic>((x) => x.toJson())),
      };
}
