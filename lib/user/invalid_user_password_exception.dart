class InvalidUserPasswordException implements Exception {
  final String message;

  InvalidUserPasswordException(this.message);
}