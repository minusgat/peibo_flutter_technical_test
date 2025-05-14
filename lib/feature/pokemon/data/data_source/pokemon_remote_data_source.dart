import 'dart:developer';

import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result_response_handler.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/models.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_detail/pokemon_detail.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/models/pokemon_specie/pokemon_specie_model.dart';

class PokemonRemoteDataSource with ResponseHandler {
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
        final message =
            response.asFailureOrNull()?.message ?? 'Failed to load pokemons';
        return Result.failure(message);
      }

      final apiResponse = response.asSuccessOrNull()?.data;
      final result = apiResponse?.data.results;

      if (result == null) {
        return Result.failure('Failed to load pokemons');
      }

      return Result.success(result);
    } catch (e, stackTrace) {
      final message = 'Failed to load pokemons';
      log('Error: $e');
      log('StackTrace: $stackTrace');
      log('Message: $message');
      return Result.failure(message, Cause(e, stackTrace));
    }
  }

  Future<Result<PokemonDetailModel>> getPokemon({required int id}) async {
    try {
      final response = await dioApiClient.get(
        '/pokemon/$id',
        decoder: (data) => PokemonDetailModel.fromJson(data),
      );

      final result = handleResponse(
        response,
        (data) => data as PokemonDetailModel,
      );

      return result;
    } catch (e, stackTrace) {
      final message = 'Failed to load pokemon';
      log('Error: $e');
      log('StackTrace: $stackTrace');
      log('Message: $message');
      return Result.failure(message, Cause(e, stackTrace));
    }
  }

  Future<Result<PokemonSpecieModel>> getPokemonSpecie({required int id}) async {
    try {
      final response = await dioApiClient.get(
        '/pokemon-species/$id',
        decoder: (data) => PokemonSpecieModel.fromJson(data),
      );

      final result = handleResponse(
        response,
        (data) => data as PokemonSpecieModel,
      );
      return result;
    } catch (e, stackTrace) {
      final message = 'Failed to load pokemon specie';
      log('Error: $e');
      log('StackTrace: $stackTrace');
      log('Message: $message');
      return Result.failure(message, Cause(e, stackTrace));
    }
  }
}
