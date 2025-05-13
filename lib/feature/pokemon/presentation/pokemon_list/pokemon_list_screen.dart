import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_app_bar.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_retry.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_provider.dart';

class PokemonListPage extends ConsumerWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: _appBar(context),
      body: asyncValue.when(
        loading: () => CircularProgressIndicator(),
        error: (e, _) => _retryButton(e, ref),
        data: (pokemons) => PokemonList(pokemons: pokemons),
      ),
    );
  }

  _retryButton(e, WidgetRef ref) {
    return Center(
      child: CustomRetry(
        error: e,
        onRetry: () {
          ref.read(pokemonListProvider.notifier).reset();
        },
        stacktrace: null,
      ),
    );
  }

  _appBar(BuildContext context) {
    return CustomAppBar(
      toolbarHeight: 100,
      title: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your ',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 64.0),
              child: Image.asset(width: 156, 'assets/pokemon_logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
