import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/common/widgets/custom_badge.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/utils/pokemon_name_formater.dart';

class PokemonDescription extends StatelessWidget {
  const PokemonDescription({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 56, fontWeight: FontWeight.w600);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CustomBadge(text: "${pokemon.id}"),
        ),
        Text(' ${pokemon.name.capitalize}', style: textStyle),
      ],
    );
  }
}
