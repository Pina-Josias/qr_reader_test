import 'package:get_it/get_it.dart';
import 'package:qr_code_feature/domain/repositories/repositories.dart';
import 'package:qr_code_feature/features/usecases/delete_code.dart';

/// Delete code use case factory
DeleteCodeUseCase makeDeleteCodeUseCase() =>
    DeleteCodeUseCase(repository: GetIt.I<LocalScannedCodesRepo>());
