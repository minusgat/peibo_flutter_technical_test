import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/domain/entities/pokemon.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/common/widgets/pokeball.dart';
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

    final titelStyle = Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.w600);
    final subtitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w400,
    );

    return RefreshIndicator(
      onRefresh: () async => _reset(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: _appBar(titelStyle, subtitleStyle),
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
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: PokemonItem(pokemon: pokemon, size: itemExtent),
              );
            }, childCount: widget.pokemons.length),
          ),
        ],
      ),
    );
  }

  Column _appBar(TextStyle? titelStyle, TextStyle? subtitleStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select your', style: titelStyle),

        Row(
          children: [
            Text('Pokemon', style: subtitleStyle),
            SizedBox(width: 8),
            Pokeball(size: 24),
          ],
        ),
      ],
    );
  }
}
