import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_detail/pokemon_detail.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_specie/pokemon_specie_model.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

/// Extention to map [PokemonDetail] from [PokemonDetailModel]
extension PokemonDetailModelMapper on PokemonDetailModel {
  Result<Pokemon> toDomain({PokemonSpecieModel? pokemonSpecieModel}) {
    try {
      final photoUrl = sprites.other.home.frontDefault;
      final pokemonTypes = types.map((type) => type.type.name).toList();

      final color = pokemonSpecieModel?.color.name;

      return Success(
        Pokemon(
          id: id,
          name: name,
          photoUrl: photoUrl ?? '',
          types: pokemonTypes,
          height: height,
          weight: weight,
          color: color,
        ),
      );
    } catch (e) {
      return Failure('Failed to parse PokemonDetailModel: $e');
    }
  }
}
