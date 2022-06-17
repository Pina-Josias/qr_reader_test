import 'package:qr_code_feature/data/usecases/local_scanned_codes.dart';
import 'package:qr_reader_test/main/factories/cache/cache.dart';

/// Data Local Scanned Codes Factory in Domain Layer
DataLocalScannedCodes makeDataLocalScannedCodes() =>
    DataLocalScannedCodes(storage: makeCacheAdapter());
