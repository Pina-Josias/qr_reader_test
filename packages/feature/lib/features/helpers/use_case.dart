import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_feature/features/failures/failure.dart';

/// Create a Generic Handler of Use Cases
///  and return a Either<Failure, T>
mixin UseCase<Type, Params> {
  /// Generic implementation of an use case
  Future<Either<Failure, Type>>? call(Params params);
}

/// Class for Empty Data for an Use Case
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
