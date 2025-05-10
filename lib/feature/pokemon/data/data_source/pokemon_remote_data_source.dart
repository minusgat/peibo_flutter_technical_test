import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/models.dart';

class PokemonRemoteDataSource {
  final DioApiClient dioApiClient;

  PokemonRemoteDataSource(this.dioApiClient);

  Future<Result<List<PokemonModel>>> getPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await dioApiClient.get(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
        decoder:
            (data) => PaginatedResponse<PokemonModel>.fromJson(
              data,
              (json) => PokemonModel.fromJson(json as Map<String, dynamic>),
            ),
      );

      if (response.isFailure) {
        final message = response.asFailureOrNull()?.message??'Failed to load pokemons';
        return Result.failure(message);
      }

      final apiResponse = response.asSuccessOrNull()?.data;
      final result = apiResponse?.data.results;

      if (result == null) {
        return Result.failure('Failed to load pokemons');
      }

      return Result.success(result);
    } catch (e, stackTrace) {
      return Result.failure('Failed to load pokemons', Cause(e, stackTrace));
    }
  }
}
