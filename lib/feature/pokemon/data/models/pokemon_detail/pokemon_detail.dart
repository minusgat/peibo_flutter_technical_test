// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail.freezed.dart';
part 'pokemon_detail.g.dart';

@freezed
abstract class PokemonDetailModel with _$PokemonDetailModel {
  const factory PokemonDetailModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    required Sprites sprites,
    required List<PokemonTypeSlot> types,
    required List<Stat> stats,
  }) = _PokemonDetailModel;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);
}

@freezed
abstract class Sprites with _$Sprites {
  const factory Sprites({required OtherSprites other}) = _Sprites;

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);
}

@freezed
abstract class OtherSprites with _$OtherSprites {
  const factory OtherSprites({required HomeSprites home}) = _OtherSprites;

  factory OtherSprites.fromJson(Map<String, dynamic> json) =>
      _$OtherSpritesFromJson(json);
}

@freezed
abstract class HomeSprites with _$HomeSprites {
  const factory HomeSprites({
    @JsonKey(name: 'front_default') required String? frontDefault,
  }) = _HomeSprites;

  factory HomeSprites.fromJson(Map<String, dynamic> json) =>
      _$HomeSpritesFromJson(json);
}

@freezed
abstract class PokemonTypeSlot with _$PokemonTypeSlot {
  const factory PokemonTypeSlot({
    required int slot,
    required PokemonType type,
  }) = _PokemonTypeSlot;

  factory PokemonTypeSlot.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeSlotFromJson(json);
}

@freezed
abstract class PokemonType with _$PokemonType {
  const factory PokemonType({required String name, required String url}) =
      _PokemonType;

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);
}

@freezed
abstract class Stat with _$Stat {
  const factory Stat({
    @JsonKey(name: 'base_stat') required int baseStat,
    required int effort,
    required StatType stat,
  }) = _Stat;

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
}

@freezed
abstract class StatType with _$StatType {
  const factory StatType({required String name, required String url}) =
      _StatType;

  factory StatType.fromJson(Map<String, dynamic> json) =>
      _$StatTypeFromJson(json);
}
