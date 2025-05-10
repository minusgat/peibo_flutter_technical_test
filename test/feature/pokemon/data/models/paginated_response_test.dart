import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/paginated_response/paginated_response.dart';

void main() {
  group('PaginatedResponse', () {
    test('fromJson correctly parses JSON with generic type', () {
      // Arrange
      final json = {
        'count': 100,
        'next': 'https://api.example.com/page/2',
        'previous': null,
        'results': ['item1', 'item2', 'item3']
      };

      // Act
      final response = PaginatedResponse<String>.fromJson(
        json,
        (json) => json as String,
      );

      // Assert
      expect(response.count, 100);
      expect(response.next, 'https://api.example.com/page/2');
      expect(response.previous, isNull);
      expect(response.results, ['item1', 'item2', 'item3']);
    });

    test('fromJson handles null results', () {
      // Arrange
      final json = {
        'count': 50,
        'next': 'https://api.example.com/page/2',
        'previous': null,
        'results': null
      };

      // Act
      final response = PaginatedResponse<String>.fromJson(
        json,
        (json) => json as String,
      );

      // Assert
      expect(response.count, 50);
      expect(response.next, 'https://api.example.com/page/2');
      expect(response.previous, isNull);
      expect(response.results, isNull);
    });

    test('fromJson handles empty results', () {
      // Arrange
      final json = {
        'count': 0,
        'next': '',
        'previous': null,
        'results': []
      };

      // Act
      final response = PaginatedResponse<String>.fromJson(
        json,
        (json) => json as String,
      );

      // Assert
      expect(response.count, 0);
      expect(response.next, '');
      expect(response.previous, isNull);
      expect(response.results, isEmpty);
    });
  });
}