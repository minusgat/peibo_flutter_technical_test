import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokeon_bag/pokemon_bag_provider.dart';

class PokemonBag extends ConsumerWidget {
  const PokemonBag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(pokemonBagProvider.notifier);
    final providerState = ref.watch(pokemonBagProvider);

    return providerState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (pokemons) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          child: ListView.builder(
            itemCount: pokemons.length,
            itemExtent: 40,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              final tag = 'pokeball-${pokemon.id}';
              return GestureDetector(
                onTap: () => provider.showPokemonDetail(pokemon),
                onLongPress: () => provider.removePokemon(pokemon),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: 60,
                  child: Hero(tag: tag, child: Pokeball(size: 20)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
