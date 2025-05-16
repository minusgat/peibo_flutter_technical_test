import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_image.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/widgets/pokemon_detail_badge.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/widgets/pokemon_detail_circle_background.dart';

class PokemonItemDetail extends StatelessWidget {
  const PokemonItemDetail({
    super.key,
    required this.pokemon,
    required this.size,
  });

  final Pokemon pokemon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.3,
            child: PokemonDetailCircleBackground(width: width, id: pokemon.id),
          ),
          PokemonImage(size: size, imageUrl: pokemon.photoUrl),
          Positioned(
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: PokemonDetailBadge(id: pokemon.id),
                ),
                Text(' ${pokemon.name}', style: const TextStyle(fontSize: 64)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
