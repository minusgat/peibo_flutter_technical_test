import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peibo_flutter_technical_test/chore/configuration/theme.dart';
import 'package:peibo_flutter_technical_test/chore/provider.dart';
import 'package:peibo_flutter_technical_test/feature/pokemon/presentation/pokemon_list/pokemon_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);

    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppTheme.theme,
      home: PokemonListPage(),
    );
  }
}
