import 'package:cached_network_image/cached_network_image.dart';
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
    return Hero(
      tag: imageUrl,
      child: CachedNetworkImage(imageUrl: imageUrl, width: size, height: size),
    );
  }
}
