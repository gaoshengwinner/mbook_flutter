class NoResourceException implements Exception {
  String cause;

  NoResourceException(this.cause);
}
