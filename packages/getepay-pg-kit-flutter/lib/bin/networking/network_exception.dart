class NetworkException implements Exception {
  final String message;
  final int code;
  NetworkException({required this.message, required this.code});
}

class InternetException implements Exception {
  final String message;
  InternetException({required this.message});
}

class PermissionException implements Exception {
  final String message;
  PermissionException({required this.message});
}
