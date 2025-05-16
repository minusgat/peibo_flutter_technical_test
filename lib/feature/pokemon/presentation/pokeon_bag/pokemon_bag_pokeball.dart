import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokeon_bag/pokemon_bag_provider.dart';

class PokemonBagPokeball extends ConsumerWidget {
  const PokemonBagPokeball({super.key, required this.pokemon});

  final Pokemon pokemon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(pokemonBagProvider.notifier);

    return GestureDetector(
      onTap: () => provider.addPokemon(pokemon),
      child: Hero(tag: 'pokeball-${pokemon.id}', child: Pokeball(size: 40)),
    );
  }
}
