class BadRequest implements Exception {
  Map? _errors;

  BadRequest(Map? errors) {
    _errors = errors;
  }

  Map? get errors => _errors;
}
