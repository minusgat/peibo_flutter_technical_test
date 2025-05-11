import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:peibo_flutter_technical_test/chore/network/http/dio_client/dio_client.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/data_source/pokemon_remote_data_source.dart';

@GenerateMocks([Dio, DioApiClient,Result,PokemonRemoteDataSource])
// not required for mocks
// ignore: no-empty-block
void main() {}
