import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result_response_handler.dart';

class TestResponseHandler with ResponseHandler {}

void main() {
  late TestResponseHandler responseHandler;

  setUp(() {
    responseHandler = TestResponseHandler();
  });

  group('handleResponse', () {
    test('should return success when response is successful', () {
      // Arrange
      final successResponse = Result.success({'key': 'value'});

      // Act
      final result = responseHandler.handleResponse(
        successResponse,
        (data) => data['key'] as String,
      );

      // Assert
      expect(result.isSuccess, true);
      expect(result.asSuccessOrNull()?.data, 'value');
    });

    test('should return failure when response is a failure', () {
      // Arrange
      final failureResponse = Result.failure('Error occurred');

      // Act
      final result = responseHandler.handleResponse(
        failureResponse,
        (data) => data,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.asFailureOrNull()?.message, 'Error occurred');
    });

    test('should return failure when response data is null', () {
      // Arrange
      final successResponseWithNullData = Result.success(null);

      // Act
      final result = responseHandler.handleResponse(
        successResponseWithNullData,
        (data) => data,
      );

      // Assert
      expect(result.isFailure, true);
      expect(result.asFailureOrNull()?.message, 'No data found');
    });
  });
}
