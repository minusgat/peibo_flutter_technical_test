import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/chore/provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_screen.dart';

final pokemonBagProvider =
    AsyncNotifierProvider<PokemonBagNotifier, List<Pokemon>>(
      PokemonBagNotifier.new,
    );

class PokemonBagNotifier extends AsyncNotifier<List<Pokemon>> {
  static const int maxBagSize = 6;

  @override
  Future<List<Pokemon>> build() async => const <Pokemon>[];

  Future<void> addPokemon(Pokemon pokemon) async {
    final currentList = state.value ?? const <Pokemon>[];

    final isAlreadyInBag = currentList.any((p) => p.id == pokemon.id);
    final isBagFull = currentList.length >= maxBagSize;

    if (isAlreadyInBag || isBagFull) {
      HapticFeedback.vibrate();
      return;
    }

    final updatedList = [pokemon, ...currentList];
    HapticFeedback.lightImpact();
    state = AsyncData(updatedList);

    ref.read(routerProvider).pop();
  }

  Future<void> removePokemon(Pokemon pokemon) async {
    final currentList = state.value ?? const <Pokemon>[];
    final updatedList = currentList.where((p) => p.id != pokemon.id).toList();
    HapticFeedback.lightImpact();
    state = AsyncData(updatedList);
  }

  Future<void> showPokemonDetail(Pokemon pokemon) async {
    HapticFeedback.lightImpact();

    final result = await ref
        .read(routerProvider)
        .push((context) => PokemonDetailScreen(pokemon: pokemon, size: 600));
    log('Result: $result');
  }
}
