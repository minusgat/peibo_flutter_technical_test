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

    test('Result.emptySuccess returns a Success with EmptyContent', () {
      //Arrange
      final result = Result.emptySuccess();

      //Act & Assert
      expect(result.isSuccess, isTrue);
      expect(result, isA<Success<EmptyContent>>());
      expect(result.asSuccessOrNull()?.data, isA<EmptyContent>());
    });
  });

  group('Failure', () {
    test('can be created with a message', () {
      //Arrange
      const failure = Failure('Network error');

      //Act & Assert
      expect(failure.message, 'Network error');
      expect(failure.failCause, isNull);
    });

    test('can be created with a message and a Cause', () {
      //Arrange
      final cause = Cause('IOException', StackTrace.current);

      //Act
      final failure = Failure('File operation failed', cause);

      //Assert
      expect(failure.message, 'File operation failed');
      expect(failure.failCause, same(cause));
    });


  });

    group('Cause', () {
    test('can be created with an error', () {
      //Arrange
      const cause = Cause('NullPointerException');

      //Act & Assert
      expect(cause.error, 'NullPointerException');
      expect(cause.stackTrace, isNull);
    });

    test('can be created with an error and a StackTrace', () {
      //Arrange
      final stackTrace = StackTrace.current;

      //Act
      final cause = Cause('FormatException', stackTrace);

      //Assert
      expect(cause.error, 'FormatException');
      expect(cause.stackTrace, same(stackTrace));
    });
  });
}
