class ConnectionErrorException implements Exception {
  String cause;
  ConnectionErrorException(this.cause);
}
