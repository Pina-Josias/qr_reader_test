import 'package:equatable/equatable.dart';

/// Estructure to represent a failure in the domain layer.
abstract class Failure extends Equatable {
  /// Create an insance of Failure
  const Failure({this.data, this.error});

  /// Error description
  final String? error;

  /// Data associated with the failure
  /// if the failure has a data to display.
  final dynamic data;

  @override
  List<Object> get props => [error!];

  @override
  String toString() {
    return 'Failure Error:  $error';
  }
}
