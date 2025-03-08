import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/search_cubit.dart';
import 'search_pokemon_delegate.dart';

class SearchSuccess extends StatefulWidget {
  const SearchSuccess({super.key});

  @override
  State<SearchSuccess> createState() => _SearchSuccessState();
}

class _SearchSuccessState extends State<SearchSuccess> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        final state = context.read<SearchCubit>().state;
        if (state is SearchSuccessState) {
          showSearch(
            context: context,
            delegate: SearchPokemonDelegate(state.result),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Avoids overflow by adding padding
          child: Text(
            "Search for Pokémon",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
