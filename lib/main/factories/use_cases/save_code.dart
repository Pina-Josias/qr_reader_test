import 'package:qr_code_feature/features/usecases/save_code.dart';
import 'package:qr_reader_test/main/factories/repositories/repositories.dart';

/// Save code use case factory
SaveCodeUseCase makeSaveCodeUseCase() =>
    SaveCodeUseCase(repository: makeLocalScannedCodesRepo());
