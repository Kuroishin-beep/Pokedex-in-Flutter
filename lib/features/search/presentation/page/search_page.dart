import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../designs/components/error_page.dart';
import '../../../../designs/components/loading_page.dart';
import '../cubit/search_cubit.dart';
import '../widgets/search_success.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<SearchCubit>()..requestResources(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Pokémon'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchSuccessState) {
                  return const SearchSuccess(); // Ensure this widget handles overflow
                } else if (state is SearchFailureState) {
                  return ErrorPage(
                    onTap: () => context.read<SearchCubit>().requestResources(),
                  );
                } else {
                  return const LoadingPage(); // Check constraints here too
                }
              },
            );
          },
        ),
      ),
    );
  }
}