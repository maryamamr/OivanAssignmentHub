class ConnectionException implements Exception {
  final String message;
  ConnectionException(this.message);
  @override
  String toString() => message;
}

class RedundantRequestException implements Exception {
  final String message;
  RedundantRequestException(this.message);
  @override
  String toString() => message;
}

class RequestException implements Exception {
  final String message;
  RequestException(this.message);
  @override
  String toString() => message;
}
