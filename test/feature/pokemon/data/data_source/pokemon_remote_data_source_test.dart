import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/api_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/data_source/pokemon_remote_data_source.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/paginated_response/paginated_response.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon/pokemon_model.dart';

import '../../../../test_utils/mocks.mocks.dart';

void main() {
  late MockDioApiClient mockApiClient;
  late PokemonRemoteDataSource remoteDataSource;

  setUp(() {
    mockApiClient = MockDioApiClient();
    remoteDataSource = PokemonRemoteDataSource(mockApiClient);
  });

  group('getPokemons', () {
    test('should return a list of PokemonModel on success', () async {
      // Arrange
      final mockResponse = PaginatedResponse<PokemonModel>(
        count: 1,
        next: '',
        results: [PokemonModel(name: 'Pikachu', url: 'url')],
      );

      when(
        mockApiClient.get<PaginatedResponse<PokemonModel>>(
          '/pokemon',
          queryParameters: {'limit': 20, 'offset': 0},
          decoder: anyNamed('decoder'),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          ApiResponse<PaginatedResponse<PokemonModel>>(
            data: mockResponse,
            statusCode: 200,
          ),
        ),
      );

      // Act
      final response = await remoteDataSource.getPokemons();
      final result = response.asSuccessOrNull()?.data;

      // Assert
      expect(
        result,
        isA<List<PokemonModel>>().having(
          (list) => list.first.name,
          'name',
          'Pikachu',
        ),
      );
    });

    test('should return failure when results are null', () async {
      // Arrange
      final mockResponse = PaginatedResponse<PokemonModel>(
        results: null,
        count: 0,
        next: '',
      );

      when(
        mockApiClient.get(
          '/pokemon',
          queryParameters: {'limit': 20, 'offset': 0},
          decoder: anyNamed('decoder'),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          ApiResponse<PaginatedResponse<PokemonModel>>(
            data: mockResponse,
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await remoteDataSource.getPokemons();

      // Assert
      expect(result.isFailure, true);
      expect(result.asFailureOrNull()?.message, 'Failed to load pokemons');
    });

    test('should return failure when an exception is thrown', () async {
      // Arrange
      when(
        mockApiClient.get(
          '/pokemon',
          queryParameters: {'limit': 20, 'offset': 0},
          decoder: anyNamed('decoder'),
        ),
      ).thenThrow(Exception('Network error'));

      // Act
      final result = await remoteDataSource.getPokemons();

      // Assert
      expect(result.isFailure, true);
      expect(result.asFailureOrNull()?.message, 'Failed to load pokemons');
      expect(
        result.asFailureOrNull()?.failCause?.error,
        isA<Exception>().having(
          (e) => e.toString(),
          'error',
          contains('Network error'),
        ),
      );
    });
  });
}
