class InvalidOTPException implements Exception {
  final String message;

  InvalidOTPException(this.message);
}