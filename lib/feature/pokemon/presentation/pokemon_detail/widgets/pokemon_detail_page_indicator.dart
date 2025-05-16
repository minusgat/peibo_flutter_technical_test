import 'package:flutter/material.dart';

class PokemonDetailPageIndicator extends StatelessWidget {
  const PokemonDetailPageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            ['Overview', 'Stats', 'Abilities'] 
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
