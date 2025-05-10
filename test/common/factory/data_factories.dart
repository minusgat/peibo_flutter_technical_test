import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/models.dart';

PokemonModel pokemonModelFactory({
  String name = 'bulbasaur',
  String url = 'https://pokeapi.co/api/v2/pokemon/1/',
}) {
  return PokemonModel(name: name, url: url);
}

PokemonHabitat pokemonHabitatFactory({
  String name = 'forest',
  String url = 'https://pokeapi.co/api/v2/pokemon-habitat/1/',
}) {
  return PokemonHabitat(name: name, url: url);
}

PokemonColor pokemonColorFactory({
  String name = 'green',
  String url = 'https://pokeapi.co/api/v2/pokemon-color/1/',
}) {
  return PokemonColor(name: name, url: url);
}

PokemonSpecie pokemonSpecieFactory({
  int id = 1,
  String name = 'bulbasaur',
  PokemonColor? color,
  PokemonHabitat? habitat,
}) {
  return PokemonSpecie(
    id: id,
    name: name,
    color: color ?? pokemonColorFactory(),
    habitat: habitat ?? pokemonHabitatFactory(),
  );
}

List<PokemonSpecie> pokemonSpecieListFactory({int length = 10}) {
  return List.generate(length, (index) => pokemonSpecieFactory(id: index + 1));
}

List<PokemonColor> pokemonColorListFactory({int length = 10}) {
  return List.generate(
    length,
    (index) => pokemonColorFactory(name: 'color $index'),
  );
}

List<PokemonHabitat> pokemonHabitatListFactory({int length = 10}) {
  return List.generate(
    length,
    (index) => pokemonHabitatFactory(name: 'habitat $index'),
  );
}
