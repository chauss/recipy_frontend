class HttpReadResult<T> {
  final bool success;
  final int? errorCode;
  final T? data;

  HttpReadResult({required this.success, this.errorCode, this.data});
}
