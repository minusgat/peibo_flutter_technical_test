import 'package:flutter/material.dart';

class PokemonBackground extends StatelessWidget {
  const PokemonBackground({
    super.key,
    required this.size,
    this.offset = 0,
    this.color,
  });

  final double size;
  final double offset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[200],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
