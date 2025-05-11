//Extension of pokemonMode

import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon/pokemon_model.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

/// Extention to map [Pokemon] from [PokemonModel]
extension PokemonModelMapper on PokemonModel {
  Result<Pokemon> toDomain() {
    try {
      final segments = url.split('/');
      final idSegmentPosition = 6;

      final hasIdSegment =
          segments.length > idSegmentPosition &&
          int.tryParse(segments[idSegmentPosition]) != null;

      if (hasIdSegment) {
        final id = int.parse(segments[6]);

        return Success(Pokemon(id: id, name: name));
      } else {
        final errorMessage =
            'Invalid URL format: $url. Unable to extract Pokemon ID.';
        return Failure(errorMessage);
      }
    } catch (e) {
      return Failure('Failed to parse PokemonModel: $e');
    }
  }
}
