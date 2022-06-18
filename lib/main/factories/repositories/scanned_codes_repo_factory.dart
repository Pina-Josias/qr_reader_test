import 'package:get_it/get_it.dart';
import 'package:qr_code_feature/data/usecases/use_cases.dart';
import 'package:qr_code_feature/domain/repositories/repositories.dart';

/// Repository Implementation Factory for Local Scanned Codes
LocalScannedCodesRepo makeLocalScannedCodesRepo() =>
    LocalScannedCodesRepo(local: GetIt.I<DataLocalScannedCodes>());
