import 'package:dio/dio.dart';

import '../api_client.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient({required Dio dio}) : _dio = dio;

  @override
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      final ressponseData = response.data;

      final decodedData =
          decoder != null ? decoder(ressponseData) : ressponseData as T;

      return ApiResponse(
        data: decodedData,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map.map((k, v) => MapEntry(k, v.join(','))),
      );
    } on DioException catch (e) {
      throw Exception('GET request failed: ${e.message}');
    }
  }
}
