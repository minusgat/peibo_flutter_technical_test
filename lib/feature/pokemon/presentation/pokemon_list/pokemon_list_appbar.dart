import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';

class PokemonListAppbar extends StatelessWidget {
  const PokemonListAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final titelStyle = Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.w600);

    final subtitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select your', style: titelStyle),
        Row(
          children: [
            Text('Pokemon', style: subtitleStyle),
            SizedBox(width: 8),
            Pokeball(size: 24),
          ],
        ),
      ],
    );
  }
}
