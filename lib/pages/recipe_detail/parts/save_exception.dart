import 'dart:io';

class SaveException implements IOException {
  final String message;
  final int errorCode;

  const SaveException({
    required this.message,
    required this.errorCode,
  });

  @override
  String toString() {
    return "SaveException: $errorCode => $message";
  }
}
