import 'package:qr_code_feature/domain/helpers/data_domain_error.dart';
import 'package:qr_code_feature/features/failures/failure.dart';

/// Returs on domain failure when cache is not available.
class CacheFailure extends Failure {
  /// Create an instance of CacheFailure
  /// to send a error message to the user and error status.
  const CacheFailure({
    this.domainError = DataDomainError.none,
    super.error,
  });

  /// Status of the error.
  final DataDomainError? domainError;
}
