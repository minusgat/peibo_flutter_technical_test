import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/data_source/pokemon_remote_data_source.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/mappers/pokemon_detail_model_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/mappers/pokemon_model_mapper.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Pokemon>>> getPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    final pokemons = await remoteDataSource.getPokemons(
      limit: limit,
      offset: offset,
    );

    if (pokemons.isFailure) {
      return Result.failure(
        pokemons.asFailureOrNull()?.message ?? 'Failed to load pokemons',
      );
    }

    final result =
        pokemons
            .asSuccessOrNull()
            ?.data
            .map((e) => e.toDomain())
            .where((result) => result.isSuccess)
            .map((result) => result.asSuccessOrNull()!.data)
            .toList();

    if (result == null) {
      return Result.failure('Failed to map pokemons');
    }

    return Result.success(result);
  }

  @override
  Future<Result<Pokemon>> getPokemon({required int id}) {
    return remoteDataSource.getPokemon(id: id).then((r) async {
      if (r.isFailure) {
        return Result.failure(
          r.asFailureOrNull()?.message ?? 'Failed to load pokemon',
        );
      }

      final pokemonDetail = r.asSuccessOrNull()?.data;
      if (pokemonDetail == null) {
        return Result.failure('Failed to load pokemon');
      }

      final retrieveSpecie = await remoteDataSource.getPokemonSpecie(id: id);
      final pokemonSpecie = retrieveSpecie.asSuccessOrNull()?.data;

      final result =
          pokemonDetail
              .toDomain(pokemonSpecieModel: pokemonSpecie)
              .asSuccessOrNull()
              ?.data;

      if (result == null) {
        return Result.failure('Failed to map pokemon');
      }

      return Result.success(result);
    });
  }
}
