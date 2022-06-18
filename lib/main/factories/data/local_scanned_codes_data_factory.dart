import 'package:get_it/get_it.dart';
import 'package:qr_code_feature/data/usecases/use_cases.dart';
import 'package:qr_code_feature/infraestructure/cache/cache.dart';

/// Data Local Scanned Codes Factory in Domain Layer
DataLocalScannedCodes makeDataLocalScannedCodes() =>
    DataLocalScannedCodes(storage: GetIt.I<LocalStorageAdapter>());
