import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({super.key, required this.pokemon, required this.isCenter});

  final bool isCenter;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight * .6;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: height,
        width: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image.asset('assets/pokeball.png', height: 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 1.0,
                  ),
                  child: Text('# ${pokemon.id}'),
                ),
              ),
            ),
            Text(' ${pokemon.name}', style: const TextStyle(fontSize: 36)),
          ],
        ),
      ),
    );
  }
}
