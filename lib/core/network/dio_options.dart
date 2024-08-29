import 'package:dio/dio.dart';

Map<String, String> _commonHeaders = {
  'Content-Type': 'application/json; charset=utf-8',
  'Accept': 'application/json; charset=utf-8',
  'Accept-Encoding': 'gzip',
};

class BuildBaseOptions {
  BaseOptions _baseOptions = BaseOptions();
  BuildBaseOptions buildBaseUrl() => this
    .._baseOptions = _baseOptions.copyWith(
        baseUrl: const String.fromEnvironment("BASE_URL"));
  BuildBaseOptions buildCommonHeaders() => this
    .._baseOptions = _baseOptions.copyWith(
      headers: {
        ..._baseOptions.headers,
        ..._commonHeaders,
      },
    );

  BaseOptions build() => _baseOptions;
  BaseOptions call() => build();
}
