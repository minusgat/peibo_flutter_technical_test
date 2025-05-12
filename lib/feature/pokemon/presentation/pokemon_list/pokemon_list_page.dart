import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_item/pokemon_item.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_view_provider.dart';

class PokemonListPage extends ConsumerStatefulWidget {
  const PokemonListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PokemonListPagesState();
}

class _PokemonListPagesState extends ConsumerState<PokemonListPage> {
  final ScrollController _controller = ScrollController();

  void _nextPage() {
    ref.read(pokemonListProvider.notifier).loadNextPage();
  }

  @override
  void initState() {
    super.initState();
    _nextPage();

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        _nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(pokemonListProvider);

    return Scaffold(
      body: asyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (pokemons) => Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: ListView.builder(
                controller: _controller,
                itemCount: pokemons.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final currentItem = pokemons[index];

                  return PokemonItem(pokemon: currentItem, size: 460);
                },
              ),
            ),
      ),
    );
  }
}
