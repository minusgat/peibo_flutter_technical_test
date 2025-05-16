import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/providers.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_state.dart';

final pokemonDetailProvider = StateNotifierProvider.autoDispose
    .family<PokemonDetailNotifier, PokemonDetailState, int>((ref, id) {
      final pokemonRepository = ref.watch(repositoryProvider);
      return PokemonDetailNotifier(pokemonRepository, id);
    });

class PokemonDetailNotifier extends StateNotifier<PokemonDetailState> {
  final PokemonRepositoryImpl pokemonRepository;

  PokemonDetailNotifier(this.pokemonRepository, int id)
    : super(const PokemonDetailState.initial()) {
    getPokemonDetail(id);
  }

  Future<void> getPokemonDetail(int id) async {
    state = const PokemonDetailState.loading();
    final pokemon = await pokemonRepository.getPokemon(id: id);

    if (pokemon.asFailureOrNull() case final failure?) {
      state = PokemonDetailState.error(failure.message);
      return;
    }

    if (pokemon.asSuccessOrNull() case final result?) {
      state = PokemonDetailState.loaded(result.data);
      return;
    }

    state = const PokemonDetailState.error('Failed to load Pokémon details');
  }
}
