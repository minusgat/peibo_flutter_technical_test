import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_color.freezed.dart';
part 'pokemon_color.g.dart';

@freezed
abstract class PokemonColor with _$PokemonColor {
  const factory PokemonColor({required String name, required String url}) =
      _PokemonColor;

  factory PokemonColor.fromJson(Map<String, dynamic> json) =>
      _$PokemonColorFromJson(json);
}
