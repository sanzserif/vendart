import 'package:equatable/equatable.dart';

/// Base failure class for the application
/// Failures represent errors that have been caught and handled
sealed class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failure representing server-side errors
final class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Failure representing cache/local storage errors
final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Failure representing network connectivity issues
final class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.code,
  });
}

/// Failure representing authentication issues
final class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

/// Failure representing validation errors
final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}
