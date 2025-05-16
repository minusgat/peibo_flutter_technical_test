import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/utils/pokemon_name_formater.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_image.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/widgets/pokemon_detail_badge.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PokemonImage(size: size, imageUrl: pokemon.photoUrl),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: PokemonDetailBadge(id: pokemon.id),
                ),
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Text(
                    ' ${pokemon.name.capitalize}',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
