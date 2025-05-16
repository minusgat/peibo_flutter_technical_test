// dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:peibo_flutter_technical_test/chore/provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokeon_bag/pokemon_bag_provider.dart';

import '../../../../test_utils/mocks.mocks.dart';
import '../../../../test_utils/state_listener_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAppRouterImpl mockRouter;
  late ProviderContainer container;
  late Pokemon testPokemon;

  setUp(() {
    mockRouter = MockAppRouterImpl();
    container = ProviderContainer(
      overrides: [routerProvider.overrideWithValue(mockRouter)],
    );
    testPokemon = Pokemon(id: 1, name: 'Bulbasaur');
  });

  group('PokemonBagNotifier', () {
    test('adds a new Pokemon if not in bag and bag not full', () async {
      final states = <AsyncValue<List<Pokemon>>>[];
      final notifier = container.read(pokemonBagProvider.notifier);

      //Arrange
      final stateListener = StateChangeListener<AsyncValue<List<Pokemon>>>();
      final listener = container.listen<AsyncValue<List<Pokemon>>>(
        pokemonBagProvider,
        (previous, next) {
          states.add(next);
          stateListener.call(previous, next);
        },
        fireImmediately: true,
      );

      //Act
      await notifier.addPokemon(testPokemon);
      await Future.delayed(const Duration(milliseconds: 100));

      //Assert
      expect(
        states,
        isA<List<AsyncValue<List<Pokemon>>>>().having(
          (list) => list.any((state) => state.value?.length == 1),
          'isLoading',
          isTrue,
        ),
      );
      verify(mockRouter.pop()).called(1);

      listener.close();
    });

    test('does not add a Pokemon if already in bag', () async {
      final notifier = container.read(pokemonBagProvider.notifier);
      await notifier.addPokemon(testPokemon);
      await Future.delayed(const Duration(milliseconds: 100));

      //Act
      await notifier.addPokemon(testPokemon);

      //Assert
      expect(container.read(pokemonBagProvider).value, [testPokemon]);
      verify(mockRouter.pop());
    });

    //remove
    test('removes a Pokemon from the bag', () async {
      final notifier = container.read(pokemonBagProvider.notifier);
      await notifier.addPokemon(testPokemon);
      await Future.delayed(const Duration(milliseconds: 100));

      //Act
      await notifier.removePokemon(testPokemon);

      //Assert
      expect(container.read(pokemonBagProvider).value, isEmpty);
    });

    //show
  });
}
