import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';

import '../../../../test_utils/mocks.mocks.dart';

void main() {
  test('DioApiClient should trow an exception when GET request fails', () {
    // Arrange
    final mockApiClient = MockDio();
    final apiClient = DioApiClient(dio: mockApiClient);

    when(mockApiClient.get('')).thenThrow(Exception('GET request failed: '));

    // Act && Assert
    expect(() => apiClient.get(''), throwsException);
  });
}
