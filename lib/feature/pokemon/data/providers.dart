import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/chore/provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/data_source/pokemon_remote_data_source.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/repository/pokemon_repository_impl.dart';

final remotedataSourceProvider = Provider<PokemonRemoteDataSource>((ref) {
  return PokemonRemoteDataSource(ref.read(dioApiClientProvider));
});

final repositoryProvider = Provider((ref) {
  final remoteDataSource = ref.read(remotedataSourceProvider);
  return PokemonRepositoryImpl(remoteDataSource: remoteDataSource);
});
