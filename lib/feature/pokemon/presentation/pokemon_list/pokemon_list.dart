import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_item/pokemon_item.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_provider.dart';

class PokemonList extends ConsumerStatefulWidget {
  const PokemonList({super.key, required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  ConsumerState<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends ConsumerState<PokemonList> {
  final ScrollController _scrollController = ScrollController();

  void _nextPage() {
    ref.read(pokemonListProvider.notifier).loadNextPage();
  }

  void _reset() {
    ref.read(pokemonListProvider.notifier).reset();
  }

  @override
  void initState() {
    super.initState();
    _nextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final position = _scrollController.position.pixels;
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

    return RefreshIndicator(
      onRefresh: () async => _reset(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16),
        child: ListView.builder(
          itemCount: widget.pokemons.length,
          itemExtent: itemExtent,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final currentItem = widget.pokemons[index];
            return PokemonItem(pokemon: currentItem, size: itemExtent);
          },
        ),
      ),
    );
  }
}
