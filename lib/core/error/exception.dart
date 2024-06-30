class AppException implements Exception {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  AppException(this._errorMessage);
}