class ApiResponse<T> {
  final T data;
  final int statusCode;
  final Map<String, String>? headers;

  ApiResponse({
    required this.data,
    required this.statusCode,
    this.headers,
  });

  bool get isSuccessful => statusCode == 200;
  bool get hasFailed => statusCode != 200;
}

abstract class ApiClient {
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic data)? decoder,
  });
}
