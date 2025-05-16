import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_app_bar.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/widgets/pokemon_detail_circle_background.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/widgets/pokemon_detail_surface_color.dart';

class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
    required this.size,
  });

  final Pokemon pokemon;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final toolbarHeight = 90.0;

    return Scaffold(
      body: Stack(
        children: [
          PokemonDetailSurfaceColor(pokemon.id),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * 0.8),
            child: Transform.translate(
              offset: Offset(0, toolbarHeight),
              child: Transform.scale(
                scale: 1.4,
                child: PokemonDetailCircleBackground(
                  width: width,
                  id: pokemon.id,
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 1.2,
            child: PokemonItemDetail(pokemon: pokemon, size: size),
          ),
          CustomAppBar(
            toolbarHeight: toolbarHeight,
            leading: _leadingButton(context),
            title: Image.asset('assets/pokemon_logo.png', height: 90),
          ),
        ],
      ),
    );
  }

  IconButton _leadingButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
