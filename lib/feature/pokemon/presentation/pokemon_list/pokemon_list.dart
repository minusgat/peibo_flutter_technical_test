import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_item/pokemon_item.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_appbar.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokeon_bag/pokemon_bag.dart';

class PokemonList extends ConsumerStatefulWidget {
  const PokemonList({super.key, required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  ConsumerState<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends ConsumerState<PokemonList> {
  final ScrollController _scrollController = ScrollController();

  void _nextPage() => ref.read(pokemonListProvider.notifier).loadNextPage();

  void _reset() => ref.read(pokemonListProvider.notifier).reset();

  void _onPokemonSelected(Pokemon pokemon) {
    ref.read(pokemonListProvider.notifier).showPokemonDetail(pokemon);
  }

  @override
  void initState() {
    super.initState();
    _nextPage();

    _scrollController.addListener(() {
      final position = _scrollController.position.pixels;

      if (_scrollController.position.atEdge) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final isAtBottom = position == maxScrollExtent;

        if (isAtBottom) {
          _nextPage();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemExtent = MediaQuery.of(context).size.height * .6;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async => _reset(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: PokemonListAppbar(),
                floating: true,
                pinned: false,
                snap: true,
                expandedHeight: 100,
                toolbarHeight: 90,
                surfaceTintColor: Colors.transparent,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final pokemon = widget.pokemons[index];
                  return GestureDetector(
                    onTap: () async => _onPokemonSelected(pokemon),
                    child: PokemonItem(pokemon: pokemon, size: itemExtent),
                  );
                }, childCount: widget.pokemons.length),
              ),
            ],
          ),
        ),
        Positioned(
          top: 150,
          left: 10,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .8,
              maxWidth: MediaQuery.of(context).size.width * .1,
            ),
            child: PokemonBag(),
          ),
        ),
      ],
    );
  }
}
