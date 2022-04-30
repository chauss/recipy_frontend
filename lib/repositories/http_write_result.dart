class HttpWriteResult {
  final bool success;
  final String? message;
  final int? errorCode;

  HttpWriteResult({required this.success, this.message, this.errorCode});
}
