class ApiResponse<T> {
  final T data;
  final int statusCode;
  final Map<String, String>? headers;

  ApiResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });
}

abstract class ApiClient {
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? decoder,
  });
}
