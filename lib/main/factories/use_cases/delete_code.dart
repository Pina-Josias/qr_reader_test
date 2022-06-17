import 'package:qr_code_feature/features/usecases/delete_code.dart';
import 'package:qr_reader_test/main/factories/repositories/repositories.dart';

/// Delete code use case factory
DeleteCodeUseCase makeDeleteCodeUseCase() =>
    DeleteCodeUseCase(repository: makeLocalScannedCodesRepo());
