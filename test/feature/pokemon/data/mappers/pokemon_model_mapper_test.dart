import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/mappers/pokemon_model_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon/pokemon_model.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

void main() {
  group('PokemonModelMapper', () {
    test('toDomain correctly maps PokemonModel to Pokemon', () {
      // Arrange
      const pokemonModel = PokemonModel(
        name: 'Pikachu',
        url: 'https://pokeapi.co/api/v2/pokemon/25/',
      );

      // Act
      final pokemon = pokemonModel.toDomain();
      final result = pokemon.asSuccessOrNull()?.data;

      // Assert
      expect(result, isNotNull);
      expect(
        result,
        isA<Pokemon>()
            .having((p) => p.id, 'id', 25)
            .having((p) => p.name, 'name', 'Pikachu'),
      );
    });

    test('toDomain return failure for invalid URL', () {
      // Arrange
      const pokemonModel = PokemonModel(name: 'Pikachu', url: 'invalid_url');

      // Act
      final result = pokemonModel.toDomain();
      final failure = result.asFailureOrNull();
      final errorMessage = failure?.message;

      // Assert
      expect(failure, isNotNull);
      expect(errorMessage, contains('Invalid URL format'));
    });

    test('toDomain  return failure for empty URL', () {
      // Arrange
      const pokemonModel = PokemonModel(name: 'Pikachu', url: '');

      // Act
      final result = pokemonModel.toDomain();
      final failure = result.asFailureOrNull();
      final errorMessage = failure?.message;

      // Assert
      expect(failure, isNotNull);
      expect(errorMessage, contains('Invalid URL format'));
    });
  });
}
