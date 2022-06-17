import 'package:qr_code_feature/features/usecases/load_codes.dart';
import 'package:qr_reader_test/main/factories/repositories/repositories.dart';

/// Load codes use case factory
LoadCodesUseCase makeLoadCodesUseCase() =>
    LoadCodesUseCase(repository: makeLocalScannedCodesRepo());
