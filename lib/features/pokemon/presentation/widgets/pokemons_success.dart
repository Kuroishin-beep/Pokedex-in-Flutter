import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../designs/components/loading_page.dart';
import '../../../../designs/constants/pokedex_spacing.dart';
import '../../../../designs/constants/pokedex_theme_data.dart';
import '../bloc/pokemons_bloc.dart';
import '../constant/pokemons_strings.dart';
import 'pokemon_card.dart';

class PokemonsSuccess extends StatefulWidget {
  const PokemonsSuccess({super.key});

  @override
  State<PokemonsSuccess> createState() => _PokemonsSuccessState();
}

class _PokemonsSuccessState extends State<PokemonsSuccess> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<PokemonsBloc>().state;
    final status = state.status;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          pinned: true,
          scrolledUnderElevation: 0,
          expandedHeight: 120.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding:
            const EdgeInsets.symmetric(horizontal: PokedexSpacing.kL),
            title: Text(
              PokemonStrings.title,
              style:
              textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PokedexSpacing.kL,
              vertical: PokedexSpacing.kS,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PokemonStrings.subtitle,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: PokedexThemeData.textGrey),
                ),
                const SizedBox(height: PokedexSpacing.kM),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(PokedexSpacing.kS),
                  ),
                  onTap: () => context.pushNamed('search'),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(PokedexSpacing.kS),
                      color: PokedexThemeData.greyLevelLight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PokedexSpacing.kL,
                        vertical: PokedexSpacing.kM,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: PokedexSpacing.kXS),
                          Expanded( // Prevents text overflow
                            child: Text(
                              PokemonStrings.whatAreYouLookingFor,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: PokedexThemeData.textGrey),
                              overflow: TextOverflow.ellipsis, // Ensures text does not overflow
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: PokedexSpacing.kS),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: PokedexSpacing.kL),
          sliver: SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: PokedexSpacing.kM,
            ),
            itemBuilder: (context, index) {
              final pokemon = state.result[index];
              return PokemonCard(pokemon: pokemon);
            },
            itemCount: state.result.length,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (_, __) {
              final Widget tailWidget;
              if (!state.firstPage && status == Status.loading) {
                tailWidget = const Padding(
                  padding: EdgeInsets.all(PokedexSpacing.kM),
                  child: LoadingPage(),
                );
              } else if (!state.firstPage && status == Status.failure) {
                tailWidget = Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: PokedexSpacing.kM,
                      horizontal: PokedexSpacing.kL),
                  child: Column(
                    children: [
                      Text(
                        PokemonStrings.paginationErrorTitle,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: PokedexSpacing.kM),
                      Text(
                        PokemonStrings.paginationError,
                        style: textTheme.bodyMedium?.copyWith(),
                      ),
                      const SizedBox(height: PokedexSpacing.kL),
                      FilledButton(
                        onPressed: () => context
                            .read<PokemonsBloc>()
                            .add(const PokemonsRequestEvent()),
                        child: const Text(PokemonStrings.tryAgain),
                      ),
                    ],
                  ),
                );
              } else {
                tailWidget = const SizedBox.shrink();
              }
              return Padding(
                padding:
                const EdgeInsets.symmetric(vertical: PokedexSpacing.kXL),
                child: tailWidget,
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }

  void _onScrollListener() {
    if (_isBottomReached) {
      _requestPokemons();
    }
  }

  bool get _isBottomReached {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _requestPokemons() {
    context.read<PokemonsBloc>().add(const PokemonsRequestEvent());
  }
}