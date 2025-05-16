import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

part 'pokemon_detail_state.freezed.dart';

@freezed
sealed class PokemonDetailState with _$PokemonDetailState {
  const factory PokemonDetailState.initial() = Initial;
  const factory PokemonDetailState.loading() = Loading;
  const factory PokemonDetailState.loaded(Pokemon pokemon) = Loaded;
  const factory PokemonDetailState.error(String message) = Error;
}
