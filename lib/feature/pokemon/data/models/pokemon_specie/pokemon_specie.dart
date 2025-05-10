import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_color/pokemon_color.dart';

part 'pokemon_specie.freezed.dart';
part 'pokemon_specie.g.dart';

@freezed
abstract class PokemonSpecie with _$PokemonSpecie {
  const factory PokemonSpecie({
    required int id,
    required String name,
    required PokemonColor color,
    required PokemonHabitat habitat,
  }) = _PokemonSpecie;

  factory PokemonSpecie.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpecieFromJson(json);
}

@freezed
abstract class PokemonHabitat with _$PokemonHabitat {
  const factory PokemonHabitat({required String name, required String url}) =
      _PokemonHabitat;

  factory PokemonHabitat.fromJson(Map<String, dynamic> json) =>
      _$PokemonHabitatFromJson(json);
}
