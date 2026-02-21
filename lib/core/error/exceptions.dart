/// Base exception class for the application
sealed class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});
}

/// Exception thrown when a server error occurs
final class ServerException extends AppException {
  const ServerException({required super.message, super.code});
}

/// Exception thrown when a cache/local storage error occurs
final class CacheException extends AppException {
  const CacheException({required super.message, super.code});
}

/// Exception thrown when there's no network connection
final class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code,
  });
}

/// Exception thrown when authentication fails
final class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

/// Exception thrown when a resource is not found
final class NotFoundException extends AppException {
  const NotFoundException({required super.message, super.code});
}
