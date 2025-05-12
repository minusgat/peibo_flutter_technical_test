import 'package:flutter/material.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    super.key,
    required this.size,
    this.padding = 16,
    required this.imageUrl,
  });

  final double size;
  final double padding;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, width: size, height: size);
  }
}
