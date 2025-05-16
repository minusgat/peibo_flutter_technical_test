import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/chore/provider.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/providers.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_screen.dart';

final pokemonListProvider =
    AsyncNotifierProvider<PokemonListNotifier, List<Pokemon>>(
      PokemonListNotifier.new,
    );

class PokemonListNotifier extends AsyncNotifier<List<Pokemon>> {
  int _currentPage = 0;
  bool _reachLimit = true;
  bool _isLoading = false;

  @override
  Future<List<Pokemon>> build() async => List<Pokemon>.empty();

  Future<void> loadNextPage() async {
    if (_isLoading || !_reachLimit) return;

    _isLoading = true;
    final client = ref.read(repositoryProvider);

    const pageSize = 1000;
    final offset = _currentPage * pageSize;

    try {
      final newPokemons = await client.getPokemons(
        offset: offset,
        limit: pageSize,
      );

      if (newPokemons.isFailure) {
        final result = newPokemons.asFailureOrNull();
        final message =
            result?.message ?? 'An error occurred while fetching the pokemons';
        final stackTrace = result?.failCause?.stackTrace ?? StackTrace.current;
        state = AsyncError(message, stackTrace);
        return;
      }

      final pokemons = newPokemons.asSuccessOrNull();

      if (pokemons == null) {
        state = AsyncData([]);
        return;
      }

      final result = pokemons.data;

      final List<Pokemon> updatedList = [
        ...state.value ?? List<Pokemon>.empty(),
        ...result,
      ];

      _currentPage++;
      _reachLimit = result.isNotEmpty;
      state = AsyncData(updatedList);
    } catch (e, s) {
      state = AsyncError(e, s);
    } finally {
      _isLoading = false;
    }
  }

  void reset() {
    _currentPage = 0;
    _reachLimit = true;
    state = const AsyncData([]);
    loadNextPage();
  }

  Future<void> showPokemonDetail(Pokemon pokemon) async {
    final router = ref.read(routerProvider);

    final result = await router.push(
      (context) => PokemonDetailScreen(pokemon: pokemon, size: 600),
    );

    log('Result: $result');
  }
}
