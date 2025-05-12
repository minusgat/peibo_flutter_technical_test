import 'package:flutter/material.dart';

class Pokeball extends StatelessWidget {
  const Pokeball({super.key, required this.size, this.padding = 16});

  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Image.asset(width: size, height: size, 'assets/pokeball.png');
  }
}
