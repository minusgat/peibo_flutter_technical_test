import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_badge.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

class PokemonDescription extends StatelessWidget {
  const PokemonDescription({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CustomBadge(text: "${pokemon.id}"),
        ),
        Text(' ${pokemon.name}', style: const TextStyle(fontSize: 64)),
      ],
    );
  }
}
