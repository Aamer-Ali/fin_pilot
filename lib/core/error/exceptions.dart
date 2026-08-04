/// Thrown by remote datasources when the backend returns a non-2xx response.
class ServerException implements Exception {
  const ServerException(this.message);
  final String message;
}

/// Thrown by remote datasources on a 401 response, or by local datasources
/// when no session is stored.
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

/// Thrown when a request fails due to connectivity/timeout rather than a
/// server response.
class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;
}
