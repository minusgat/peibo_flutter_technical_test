import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_hero_image.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.size,
    this.padding = 16,
    required this.imageUrl,
  });

  final double size;
  final double padding;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child:
          imageUrl == null
              ? Pokeball(size: size * .6)
              : CustomHeroImage(
                size: size,
                imageUrl: imageUrl!,
                placeholder: Pokeball(size: size),
              ),
    );
  }
}
