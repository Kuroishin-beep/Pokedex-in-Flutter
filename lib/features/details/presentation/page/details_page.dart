import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../designs/components/error_page.dart';
import '../../../../designs/components/loading_page.dart';
import '../../../../designs/constants/pokedex_spacing.dart' as spacing;
import '../../../../designs/constants/pokedex_theme_data.dart' as theme;
import '../../../../shared/extensions/pokemon_type_extensions.dart';
import '../../../../shared/extensions/strings_extensions.dart';
import '../cubit/details_cubit.dart';
import '../widgets/details_success.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.id});

  final int id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<DetailsCubit>()..requestPokemon(widget.id),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return TweenAnimationBuilder<Color?>(
            duration: const Duration(milliseconds: 400),
            tween: ColorTween(
              begin: theme.PokedexThemeData.backgroundDetails,
              end: state is DetailsSuccessState
                  ? state.pokemon.types.first.color.secondary
                  : theme.PokedexThemeData.backgroundDetails,
            ),
            builder: (_, newBackgroundColor, __) {
              return Scaffold(
                backgroundColor: newBackgroundColor,
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "Pokémon Details",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: spacing.PokedexSpacing.kS),
                      child: IconButton(
                        onPressed: () {
                          context.pushReplacementNamed(
                            'details',
                            pathParameters: {
                              'id': Random().nextInt(1010).toString()
                            },
                          );
                        },
                        icon: Image.asset(
                          'images/pokeball.png'.asset(),
                          color: Colors.white,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    )
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(spacing.PokedexSpacing.kM),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state is DetailsSuccessState
                          ? DetailsSuccess(pokemon: state.pokemon)
                          : state is DetailsFailureState
                          ? ErrorPage(
                        onTap: () => context.read<DetailsCubit>().requestPokemon(widget.id),
                        textColor: Colors.white,
                      )
                          : const LoadingPage(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
