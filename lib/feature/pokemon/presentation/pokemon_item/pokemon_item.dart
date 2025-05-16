import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_background.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_description.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_image.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({super.key, required this.pokemon, required this.size});

  final Pokemon pokemon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalOffset = width * .3;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PokemonBackground(size: size, offset: horizontalOffset),
          PokemonImage(size: size, imageUrl: pokemon.photoUrl),
          Positioned(bottom: 0, child: PokemonDescription(pokemon: pokemon)),
        ],
      ),
    );
  }
}
