import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';

import '../api_client.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient({required Dio dio}) : _dio = dio;

  @override
  Future<Result<ApiResponse<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? decoder,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);

      final ressponseData = response.data;

      final decodedData =
          decoder != null
              ? decoder(ressponseData)
              : _safeCast<T>(ressponseData);

      final apiResponse = ApiResponse<T>(
        data: decodedData,
        statusCode: response.statusCode ?? 0,
        headers: response.headers.map.map((k, v) => MapEntry(k, v.join(','))),
      );

      final result = Result.success(apiResponse);

      return result;
    } on DioException catch (e, s) {
      final errorMessage = switch (e) {
        DioException(type: DioExceptionType.connectionError) =>
          'Connection error occurred',
        DioException(
          type: DioExceptionType.badResponse,
          response: final response,
        ) =>
          'Received invalid status code: ${response?.statusCode}',

        _ => 'An unknown Dio error occurred',
      };

      return Result.failure(errorMessage, Cause(e, s));
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      return Result.failure('Unhandled HttpClient Error', Cause(e, stackTrace));
    }
  }

  T _safeCast<T>(dynamic data) {
    if (data is T) return data;
    throw FormatException('Expected type $T but got ${data.runtimeType}');
  }
}
