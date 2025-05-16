import 'package:flutter_test/flutter_test.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/models.dart';

void main() {
  test('PokemonModel should be created from JSON', () {
    // Arrange
    final json = {
      'name': 'Bulbasaur',
      'url': 'https://pokeapi.co/api/v2/pokemon/1/',
    };

    // Act
    final pokemon = PokemonModel.fromJson(json);

    // Assert
    expect(
      pokemon,
      isA<PokemonModel>()
          .having((p) => p.name, 'name', 'Bulbasaur')
          .having((p) => p.url, 'url', 'https://pokeapi.co/api/v2/pokemon/1/'),
    );
  });

  test('PokemonModel should be converted to JSON', () {
    // Arrange
    final pokemon = PokemonModel(
      name: 'Bulbasaur',
      url: 'https://pokeapi.co/api/v2/pokemon/1/',
    );

    // Act
    final json = pokemon.toJson();

    // Assert
    expect(json['name'], 'Bulbasaur');
    expect(json['url'], 'https://pokeapi.co/api/v2/pokemon/1/');
  });
}
