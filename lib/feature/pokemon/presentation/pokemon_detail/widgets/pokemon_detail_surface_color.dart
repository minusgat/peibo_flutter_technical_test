import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/utils/pokemon_color_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_state.dart';

class PokemonDetailSurfaceColor extends ConsumerWidget {
  const PokemonDetailSurfaceColor(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerState = ref.watch(pokemonDetailProvider(id));

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 360),
      switchInCurve: Curves.easeIn,
      child: switch (providerState) {
        Loaded(pokemon: final p) => Container(
          decoration: BoxDecoration(
            color:
                getManualPastelColorPairFromName(
                  p.color ?? 'Unknown',
                ).baseColor,
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
