
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_specie_model.freezed.dart';
part 'pokemon_specie_model.g.dart';

@freezed
abstract class PokemonSpecieModel with _$PokemonSpecieModel {
  const factory PokemonSpecieModel({
    required int id,
    required PokemonColor color,
    required PokemonHabitat habitat,
    
  }) = _PokemonSpecieModel;

  factory PokemonSpecieModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpecieModelFromJson(json);
}

@freezed
abstract class PokemonColor with _$PokemonColor {
  const factory PokemonColor({
    required String name,
    required String url,
  }) = _PokemonColor;

  factory PokemonColor.fromJson(Map<String, dynamic> json) =>
      _$PokemonColorFromJson(json);
}

@freezed
abstract class PokemonHabitat with _$PokemonHabitat {
  const factory PokemonHabitat({
    required String name,
    required String url,
  }) = _PokemonHabitat;

  factory PokemonHabitat.fromJson(Map<String, dynamic> json) =>
      _$PokemonHabitatFromJson(json);
}
