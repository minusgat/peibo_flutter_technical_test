import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_retry.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_provider.dart';

class PokemonListPage extends ConsumerWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(pokemonListProvider);

    return Scaffold(
      body: asyncValue.when(
        loading: () => CircularProgressIndicator(),
        error: (e, s) => _retryButton(e, s, ref),
        data: (pokemons) => PokemonList(pokemons: pokemons),
      ),
    );
  }

  _retryButton(Object e, StackTrace s, WidgetRef ref) {
    print('Error: $e \nStackTrace: $s');
    return Center(
      child: CustomRetry(
        error: e,
        stacktrace: s,
        onRetry: () => ref.read(pokemonListProvider.notifier).reset(),
      ),
    );
  }
}
