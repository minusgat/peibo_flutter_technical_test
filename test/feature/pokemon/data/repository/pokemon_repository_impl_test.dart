// filepath: lib/feature/pokemon/data/repository/pokemon_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon/pokemon_model.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

import '../../../../test_utils/mocks.mocks.dart';

void main() {
  late MockPokemonRemoteDataSource mockRemoteDataSource;
  late PokemonRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockPokemonRemoteDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('PokemonRepositoryImpl', () {
    test('should return failure when remote data source fails', () async {
      // Arrange
      when(
        mockRemoteDataSource.getPokemons(limit: 20, offset: 0),
      ).thenAnswer((_) async => Result.failure('Remote data source error'));

      // Act
      final result = await repository.getPokemons();

      // Assert
      expect(result.isFailure, true);
      expect(result.asFailureOrNull()?.message, 'Remote data source error');
    });

    test(
      'should return success with mapped Pokemon list when remote data source succeeds',
      () async {
        // Arrange
        final mockPokemonModels = [
          const PokemonModel(
            name: 'Pikachu',
            url: 'https://pokeapi.co/api/v2/pokemon/25/',
          ),
          const PokemonModel(
            name: 'Charmander',
            url: 'https://pokeapi.co/api/v2/pokemon/4/',
          ),
        ];

        when(
          mockRemoteDataSource.getPokemons(limit: 20, offset: 0),
        ).thenAnswer((_) async => Result.success(mockPokemonModels));

        // Act
        final response = await repository.getPokemons();
        final result = response.asSuccessOrNull()?.data;

        // Assert
        expect(response.isSuccess, true);
        expect(result, isNotNull);
        expect(result?.length, 2);
        expect(
          result,
          containsAll([
            isA<Pokemon>().having((p) => p.name, 'name', 'Pikachu'),
            isA<Pokemon>().having((p) => p.name, 'name', 'Charmander'),
          ]),
        );
      },
    );

    test('should return failure when mapping fails', () async {
      // Arrange
      final mockPokemonModels = [
        const PokemonModel(name: 'Invalid', url: 'invalid_url'),
      ];
      when(
        mockRemoteDataSource.getPokemons(limit: 20, offset: 0),
      ).thenAnswer((_) async => Result.failure('Failed to map pokemons'));

      // Act
      final response = await repository.getPokemons();
      final result = response.asFailureOrNull();

      // Assert
      expect(response.isFailure, true);
      expect(result?.message, 'Failed to map pokemons');
    });
  });
}
