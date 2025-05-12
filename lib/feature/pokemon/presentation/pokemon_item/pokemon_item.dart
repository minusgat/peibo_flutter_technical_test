import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_badge.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokemon_image.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({super.key, required this.pokemon, required this.size});

  final Pokemon pokemon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          _backgroundDecoration(context),
          _pokemonBody(),
          _pokemonDescription(),
        ],
      ),
    );
  }

  Widget _pokemonBody() {
    return pokemon.photoUrl == null
        ? Align(
          alignment: Alignment.centerRight,
          child: Pokeball(size: size * .6),
        )
        : PokemonImageWidget(size: size, imageUrl: pokemon.photoUrl!);
  }

  Transform _backgroundDecoration(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalOffset = width * .3;
    return Transform.translate(
      offset: Offset(horizontalOffset, 0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Positioned _pokemonDescription() {
    return Positioned(
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: CustomBadge(text: "${pokemon.id}"),
          ),
          Text(' ${pokemon.name}', style: const TextStyle(fontSize: 36)),
        ],
      ),
    );
  }
}
