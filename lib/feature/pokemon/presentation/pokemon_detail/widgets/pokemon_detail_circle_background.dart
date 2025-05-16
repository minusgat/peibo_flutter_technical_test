import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_animated_switcher.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/utils/pokemon_color_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_background.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_state.dart';

class PokemonDetailCircleBackground extends ConsumerWidget {
  const PokemonDetailCircleBackground({
    super.key,
    required this.width,
    required this.id,
  });

  final double width;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(pokemonDetailProvider(id));

    return CustomAnimatedSwitcher(
      child: switch (providerState) {
        Loaded(pokemon: final p) => PokemonBackground(
          size: width,
          color: p.color?.colorPair.contrastColor,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
