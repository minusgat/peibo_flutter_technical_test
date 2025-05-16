// dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/utils/result.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/data/providers.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_detail/pokemon_detail_state.dart';

import '../../../../test_utils/mocks.mocks.dart';
import '../../../../test_utils/state_listener_mock.dart';

void main() {
  late ProviderContainer container;
  late MockPokemonRepositoryImpl mockRepository;

  setUp(() {
    mockRepository = MockPokemonRepositoryImpl();
    container = ProviderContainer(
      overrides: [
        // Override the repositoryProvider to return the mock implementation
        repositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('pokemonDetailProvider', () {
    const pokemonId = 1;

    final pokemon = Pokemon(
      id: pokemonId,
      name: 'Bulbasaur',
      height: 7,
      weight: 69,
      photoUrl: 'front_default.png',
      color: 'green',
      types: ['grass', 'poison'],
      stats: {'speed': 45, 'attack': 49},
    );

    test('emits loading then loaded when repository returns success', () async {
      // Arrange
      when(
        mockRepository.getPokemon(id: pokemonId),
      ).thenAnswer((_) async => Result.success(pokemon));

      final listener = StateChangeListener<PokemonDetailState>();
      container.listen<PokemonDetailState>(
        pokemonDetailProvider(pokemonId),
        listener.call,
        fireImmediately: true,
      );

      // Act
      container.read(pokemonDetailProvider(pokemonId).notifier);
      await Future.delayed(const Duration(milliseconds: 500));

      // Assert
      verifyInOrder([
        listener(any, const PokemonDetailState.loading()),
        listener(any, PokemonDetailState.loaded(pokemon)),
      ]);

      verify(mockRepository.getPokemon(id: pokemonId));

      expect(
        container.read(pokemonDetailProvider(pokemonId)),
        PokemonDetailState.loaded(pokemon),
      );
    });

    test('emits loading then error when repository returns failure', () async {
      // Arrange
      const errorMessage = 'Failed to load Pokémon details';
      when(
        mockRepository.getPokemon(id: pokemonId),
      ).thenAnswer((_) async => Result.failure(errorMessage));

      final listener = StateChangeListener<PokemonDetailState>();
      container.listen<PokemonDetailState>(
        pokemonDetailProvider(pokemonId),
        listener.call,
        fireImmediately: true,
      );

      // Act
      container.read(pokemonDetailProvider(pokemonId).notifier);
      await Future.delayed(const Duration(milliseconds: 500));

      // Assert
      verifyInOrder([
        listener(any, const PokemonDetailState.loading()),
        listener(any, PokemonDetailState.error(errorMessage)),
      ]);

      verify(mockRepository.getPokemon(id: pokemonId));

      expect(
        container.read(pokemonDetailProvider(pokemonId)),
        PokemonDetailState.error(errorMessage),
      );
    });
  });
  
}
