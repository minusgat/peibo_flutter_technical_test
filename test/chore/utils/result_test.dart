import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';

void main() {
  group('Result', () {
    test('isSuccess returns true for Success', () {
      //Arrange
      final result = const Success(10);

      //Act & Assert
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
    });

    test('isFailure returns true for Failure', () {
      //Arrange
      final result = const Failure('Error message');

      //Act & Assert
      expect(result.isFailure, isTrue);
      expect(result.isSuccess, isFalse);
    });

    test('asSuccessOrNull returns Success object when isSuccess is true', () {
      //Arrange
      const result = Success(10);

      //Act & Assert
      expect(result.asSuccessOrNull(), isA<Success<int>>());
      expect(result.asSuccessOrNull()?.data, 10);
    });

    test('asSuccessOrNull returns null when isSuccess is false', () {
      //Arrange
      const result = Failure('Error message');

      //Act & Assert
      expect(result.asSuccessOrNull(), isNull);
    });

    test('asFailureOrNull returns Failure object when isFailure is true', () {
      //Arrange
      const result = Failure('Error message');

      //Act & Assert
      expect(result.asFailureOrNull(), isA<Failure>());
      expect(result.asFailureOrNull()?.message, 'Error message');
    });

    test('asFailureOrNull returns null when isFailure is false', () {
      //Arrange
      const result = Success(10);

      //Act & Assert
      expect(result.asFailureOrNull(), isNull);
    });
  });
}
