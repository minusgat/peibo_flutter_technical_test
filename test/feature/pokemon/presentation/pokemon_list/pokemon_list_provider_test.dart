import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/providers.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_provider.dart';

import '../../../../test_utils/mocks.mocks.dart';

void main() {
  late MockPokemonRepositoryImpl mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockPokemonRepositoryImpl();
    container = ProviderContainer(
      overrides: [repositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test(
    'loadNextPage should update state with new pokemons on success',
    () async {
    
      final notifier = container.read(pokemonListProvider.notifier);
      
      // Arrange
      final mockPokemons = List.generate(
        3,
        (index) => Pokemon(id: index, name: 'Pokemon $index'),
      );

      when(mockRepository.getPokemons(offset: 0, limit: 1000)).thenAnswer(
        (_) async => Result.success(List<Pokemon>.from(mockPokemons)),
      );

      // Act
      await notifier.loadNextPage();
      final result = notifier.state.value;

      // Assert
      expect(notifier.state, isA<AsyncData<List<Pokemon>>>());
      expect(
        result,
        isA<List<Pokemon>>()
            .having((list) => list[0].id, 'id', 0)
            .having((list) => list[1].id, 'id', 1)
            .having((list) => list[2].id, 'id', 2),
      );
    },
  );

  test('loadNextPage should set AsyncError on failure', () async {
    final notifier = container.read(pokemonListProvider.notifier);

    // Arrange
    when(
      mockRepository.getPokemons(offset: 0, limit: 1000),
    ).thenAnswer((_) async => Result.failure('Error fetching pokemons'));

    // Act
    await notifier.loadNextPage();

    // Assert
    expect(notifier.state, isA<AsyncError>());
    expect((notifier.state as AsyncError).error, 'Error fetching pokemons');
  });

  test('reset should clear the state and reset pagination', () async {
    final notifier = container.read(pokemonListProvider.notifier);
    
    // Arrange
    final mockPokemons = List.generate(
      3,
      (index) => Pokemon(id: index, name: 'Pokemon $index'),
    );

    when(
      mockRepository.getPokemons(offset: 0, limit: 1000),
    ).thenAnswer((_) async => Result.success(List<Pokemon>.from(mockPokemons)));

    // Act
    await notifier.loadNextPage();
    expect(notifier.state.value, mockPokemons);
    notifier.reset();

    // Assert
    expect(notifier.state, const AsyncData<List<Pokemon>>([]));
    verify(mockRepository.getPokemons(offset: 0, limit: 1000)).called(2);
   
  });
}