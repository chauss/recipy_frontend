class HttpReadResult<T> {
  final bool success;
  final String? error;
  final T? data;

  HttpReadResult({required this.success, this.error, this.data});
}
