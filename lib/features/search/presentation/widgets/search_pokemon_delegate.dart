import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/pokedex.dart';

import '../../../../designs/constants/pokedex_spacing.dart';
import '../../../../designs/constants/pokedex_theme_data.dart';
import '../../../../shared/extensions/int_extensions.dart';
import '../../../../shared/extensions/strings_extensions.dart';
import '../constant/search_strings.dart';

class SearchPokemonDelegate extends SearchDelegate<String> {
  SearchPokemonDelegate(
      this.resources,
      ) : super(
    searchFieldLabel: SearchStrings.title,
    searchFieldStyle: TextStyle(
      color: PokedexThemeData.textBlack,
      fontWeight: FontWeight.normal,
    ),
  );

  final List<NamedAPIResource> resources;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          close(context, '');
          context.pop();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = '';
        close(context, '');
        context.pop();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) => const SizedBox.shrink();

  @override
  void close(BuildContext context, String result) {
    if (result.isNotEmpty) {
      context.pushReplacementNamed(
        'details',
        pathParameters: {'id': _getNumber(result).toString()},
      );
    } else {
      super.close(context, result);
    }
  }

  int _getNumber(String result) {
    return resources
        .firstWhere((element) => element.name == result)
        .url
        .getNumberFromPokemonUrl();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final suggestions = query.isEmpty
        ? resources.take(30).toList()
        : resources
        .where((element) =>
        (element.name.toLowerCase()).startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        // Remove minLeadingWidth to allow tighter control
        contentPadding: const EdgeInsets.symmetric(
          horizontal: PokedexSpacing.kS, // Further reduce horizontal padding
          vertical: PokedexSpacing.kXS,
        ),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4), // Compact layout
        onTap: () {
          query = suggestions[index].name;
          close(context, query);
        },
        leading: SizedBox(
          width: 24,
          height: 24,
          child: CachedNetworkImage(
            color: PokedexThemeData.greyLevelMedium,
            imageUrl:
            suggestions[index].url.getNumberFromPokemonUrl().thumbnailUrl,
            errorWidget: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
        title: RichText(
          maxLines: 1, // Force single line
          overflow: TextOverflow.ellipsis, // Handle overflow
          text: TextSpan(
            text: suggestions[index]
                .name
                .capitalize()
                .substring(0, query.length),
            style: textTheme.bodyMedium
                ?.copyWith(color: PokedexThemeData.textBlack),
            children: [
              if (query.isEmpty) ...{
                TextSpan(
                  text: suggestions[index].name.capitalize(),
                  style: textTheme.bodyMedium
                      ?.copyWith(color: PokedexThemeData.textNumber),
                ),
              } else ...{
                TextSpan(
                  text: suggestions[index].name.substring(query.length),
                  style: textTheme.bodyMedium
                      ?.copyWith(color: PokedexThemeData.textNumber),
                ),
              }
            ],
          ),
        ),
      ),
      itemCount: suggestions.length,
    );
  }
}