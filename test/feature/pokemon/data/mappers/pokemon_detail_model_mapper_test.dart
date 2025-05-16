// filepath: lib/feature/pokemon/data/mappers/pokemon_detail_model_mapper_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/mappers/pokemon_detail_model_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_detail/pokemon_detail.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_specie/pokemon_specie_model.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

void main() {
  group('PokemonDetailModelMapper', () {
    test('should map PokemonDetailModel to Pokemon successfully', () {
      // Arrange
      const int pokemonId = 1;
      final mockPokemonDetail = PokemonDetailModel(
        id: pokemonId,
        name: 'Bulbasaur',
        height: 7,
        weight: 69,
        sprites: Sprites(
          other: OtherSprites(
            home: HomeSprites(frontDefault: 'front_default.png'),
          ),
        ),
        types: [
          PokemonTypeSlot(
            slot: 1,
            type: PokemonType(name: 'grass', url: 'url'),
          ),
          PokemonTypeSlot(
            slot: 2,
            type: PokemonType(name: 'poison', url: 'url'),
          ),
        ],
        stats: [
          Stat(
            baseStat: 45,
            effort: 12,
            stat: StatType(name: 'speed', url: 'url'),
          ),
          Stat(
            baseStat: 49,
            effort: 27,
            stat: StatType(name: 'attack', url: 'url'),
          ),
        ],
      );

      final mockPokemonSpecieModel = PokemonSpecieModel(
        id: pokemonId,
        color: PokemonColor(name: 'green', url: 'url'),
        habitat: PokemonHabitat(name: 'forest', url: 'url'),
      );

      // Act
      final result = mockPokemonDetail.toDomain(
        pokemonSpecieModel: mockPokemonSpecieModel,
      );

      // Assert
      expect(result.isSuccess, true);
      final pokemon = result.asSuccessOrNull()?.data;
      expect(
        pokemon,
        isA<Pokemon>()
            .having((p) => p.id, 'id', pokemonId)
            .having((p) => p.name, 'name', 'Bulbasaur')
            .having((p) => p.photoUrl, 'photoUrl', 'front_default.png')
            .having((p) => p.types, 'types', ['grass', 'poison'])
            .having((p) => p.height, 'height', 7)
            .having((p) => p.weight, 'weight', 69)
            .having((p) => p.color, 'color', 'green'),
      );
    });
  });
}
