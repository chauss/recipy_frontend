import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:recipy_frontend/repositories/http_read_result.dart';
import 'package:http/http.dart' as http;
import 'package:recipy_frontend/repositories/http_write_result.dart';

bool is2xx(int statusCode) => statusCode >= 200 && statusCode < 300;

HttpReadResult<T> handleHttpReadFailed<T>(
    Logger log, http.Response response, String msg) {
  String errorMessage = json.decode(utf8.decode(response.bodyBytes))["message"];
  int errorCode = json.decode(utf8.decode(response.bodyBytes))["errorCode"];
  log.warning(
      '$msg: $errorMessage (Http: ${response.statusCode}, Recipy: $errorCode)');
  return HttpReadResult(success: false, errorCode: errorCode);
}

HttpWriteResult handleHttpWriteFailed(
    Logger log, http.Response response, String msg) {
  String errorMessage = json.decode(utf8.decode(response.bodyBytes))["message"];
  int errorCode = json.decode(utf8.decode(response.bodyBytes))["errorCode"];
  log.warning(
      '$msg: $errorMessage (Http: ${response.statusCode}, Recipy: $errorCode)');
  return HttpWriteResult(success: false, errorCode: errorCode);
}
