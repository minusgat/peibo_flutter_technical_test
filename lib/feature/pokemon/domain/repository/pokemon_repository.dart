import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Result<List<Pokemon>>> getPokemons({int offset = 0, int limit = 20});
  Future<Result<Pokemon>> getPokemon({required int id});
}
