import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/api_client.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';

import '../../../../test_utils/mocks.mocks.dart';

void main() {
  test(
    'DioApiClient should trow an exception when GET request fails',
    () async {
      // Arrange
      final mockApiClient = MockDio();
      final apiClient = DioApiClient(dio: mockApiClient);

      when(mockApiClient.get('')).thenThrow(Exception('GET request failed: '));

      final response = await apiClient.get('');
      final result = response.asFailureOrNull();

      // Act && Assert
      expect(result, isA<Failure>());
    },
  );

  test(
    'DioApiClient should return ApiResponse when GET request succeeds',
    () async {
      // Arrange
      final mockApiClient = MockDio();
      final apiClient = DioApiClient(dio: mockApiClient);

      final dioResponse = Response(
        data: {'key': 'value'},
        requestOptions: RequestOptions(path: ''),
      );

      final expectedResponse = Result.success(
        ApiResponse(
          data: {'key': 'value'},
          statusCode: 200,
          headers: {'Content-Type': 'application/json'},
        ),
      );

      when(mockApiClient.get('')).thenAnswer((_) async => dioResponse);

      // Act
      final response = await apiClient.get(
        '',
        decoder: (data) => data as Map<String, String>,
      );
      final result = response.asSuccessOrNull();

      // Assert
      expect(result, isNotNull);
      expect(result.runtimeType, expectedResponse.runtimeType);
    },
  );

  test(
    'DioApiClient should return failure when decoder is not compatible with data',
    () async {
      // Arrange
      final mockApiClient = MockDio();
      final apiClient = DioApiClient(dio: mockApiClient);

      final dioResponse = Response(
        data: {'key': 'value'},
        requestOptions: RequestOptions(path: ''),
      );

      when(mockApiClient.get('')).thenAnswer((_) async => dioResponse);

      // Act
      final response = await apiClient.get(
        '',
        decoder: (data) => data as String, // Incompatible decoder
      );
      final result = response.asFailureOrNull();

      // Assert
      expect(result, isNotNull);
    },
  );
}
