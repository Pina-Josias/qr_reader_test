import 'package:qr_code_feature/domain/repositories/repositories.dart';
import 'package:qr_reader_test/main/factories/data/data.dart';

/// Repository Implementation Factory for Local Scanned Codes
LocalScannedCodesRepo makeLocalScannedCodesRepo() =>
    LocalScannedCodesRepo(local: makeDataLocalScannedCodes());
