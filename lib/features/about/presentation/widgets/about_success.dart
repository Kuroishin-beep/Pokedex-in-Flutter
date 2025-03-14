import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../designs/constants/pokedex_spacing.dart';
import '../../../../designs/constants/pokedex_theme_data.dart' as theme;
import '../../../../designs/constants/pokedex_type_color.dart';
import '../../../../designs/constants/pokedex_spacing.dart' as spacing;
import '../../../../shared/extensions/int_extensions.dart';
import '../../../../shared/extensions/pokemon_type_extensions.dart';
import '../../../../shared/extensions/strings_extensions.dart';
import '../constant/about_strings.dart';
import '../cubit/about_cubit.dart';
import 'about_tile.dart';
import 'about_weaknesses_list.dart';

class AboutSuccess extends StatelessWidget {
  const AboutSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final about =
        (context.watch<AboutCubit>().state as AboutSuccessState).about;

    final pokemon = about.pokemon;
    final species = about.pokemonSpecies;

    final textTheme = Theme.of(context).textTheme;
    final primaryColor = pokemon.types.first.color.primary;
    final sectionTheme = textTheme.titleMedium?.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.bold,
    );
    final pokemonDescription = species?.flavorTextEntries
        .firstWhereOrNull((element) => element.language.name == 'en')
        ?.flavorText
        .replaceScapeChars();

    final items = <Widget>[
      // Title
      if (pokemonDescription != null) ...{
        Text(
          pokemonDescription,
          style:
          textTheme.bodyLarge?.copyWith(color: theme.PokedexThemeData.textGrey),
        ),
      },
      // Pokedex Data
      Text(AboutStrings.pokedexData, style: sectionTheme),
      if (species != null) ...{
        AboutTile(
          title: AboutStrings.species,
          content: species.genera
              .firstWhereOrNull((element) => element.language.name == 'en')
              ?.genus,
        ),
      },
      AboutTile(
        title: AboutStrings.height,
        content: '${pokemon.height.meter.toStringAsFixed(1)}m',
        subcontent: '(${pokemon.height.cm.cmToFeedAndInches()})',
      ),
      AboutTile(
        title: AboutStrings.weight,
        content: '${pokemon.weight.kg.toStringAsFixed(1)}kg',
        subcontent: '(${pokemon.weight.lb.toStringAsFixed(1)} lbs)',
      ),
      AboutTile.list(
        title: AboutStrings.abilities,
        items: pokemon.abilities
            .map(
              (ability) => AboutTileItem(
            content:
            '${ability.ability.name}${ability.isHidden ? ' (hidden ability)' : ''}'
                .capitalizeKebabCase(),
            small: !ability.isHidden,
          ),
        )
            .toList(),
      ),
      AboutTile.custom(
        title: 'Weaknesses',
        custom: AboutWeaknessesList(weaknesses: about.weaknesses),
      ),
      // Training
      Text(AboutStrings.training, style: sectionTheme),
      if (species != null) ...{
        AboutTile(
            title: AboutStrings.catchRate,
            content: species.captureRate.toString()),
      },
      AboutTile(
        title: AboutStrings.baseExp,
        content: pokemon.baseExperience != null
            ? pokemon.baseExperience.toString()
            : AboutStrings.unknown,
      ),
      if (species != null) ...{
        AboutTile(
          title: AboutStrings.growthRate,
          content: species.growthRate.name.capitalizeKebabCase(),
        ),
      },

      // Training
      Text(AboutStrings.breeding, style: sectionTheme),

      if (species == null || species.genderRate == -1) ...{
        const AboutTile(
          title: AboutStrings.gender,
          content: AboutStrings.unknown,
        )
      } else ...{
        AboutTile.custom(
          title: AboutStrings.gender,
          custom: RichText(
            text: TextSpan(
              style: textTheme.bodyLarge,
              children: [
                TextSpan(
                    text: '♀ ',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: PokedexTypeColor.psychic.primary)),
                TextSpan(
                    text: '${species.genderRate.femaleRate.toString()}%, ',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: theme.PokedexThemeData.textGrey)),
                TextSpan(
                  text: '♂ ',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: PokedexTypeColor.water.primary),
                ),
                TextSpan(
                    text: '${species.genderRate.maleRate.toString()}%',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: theme.PokedexThemeData.textGrey)),
              ],
            ),
          ),
        ),
      },

      if (species != null) ...{
        AboutTile(
          title: AboutStrings.eggGroups,
          content: species.eggGroups
              .map((e) => e.name.capitalize().capitalizeKebabCase())
              .join(', '),
        ),
        AboutTile.custom(
          title: AboutStrings.eggCycles,
          custom: RichText(
            text: TextSpan(
              children: [
                if (species.hatchCounter != null) ...{
                  TextSpan(
                    text: '${species.hatchCounter ?? 0} ',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: theme.PokedexThemeData.textGrey),
                  ),
                  TextSpan(
                    text:
                    '(${(species.hatchCounter ?? 0) * 244} - ${(species.hatchCounter ?? 0) * 257} steps)',
                    style: textTheme.bodySmall
                        ?.copyWith(color: theme.PokedexThemeData.textGrey),
                  )
                } else ...{
                  TextSpan(
                      text: '-',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: theme.PokedexThemeData.textGrey))
                }
              ],
            ),
          ),
        )
      }
    ];

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: PokedexSpacing.kXL,
        right: PokedexSpacing.kXL,
      ),
      itemBuilder: (_, index) => index < items.length
          ? items[index]
          : const SizedBox(height: PokedexSpacing.kL),
      separatorBuilder: (_, index) {
        final double bottomSpacing;
        if (index == 0) {
          bottomSpacing = PokedexSpacing.kXL;
        } else if ([1, 6, 7, 10, 11, 14].contains(index)) {
          bottomSpacing = PokedexSpacing.kL;
        } else {
          bottomSpacing = PokedexSpacing.kM;
        }

        return SizedBox(height: bottomSpacing);
      },
      itemCount: items.length + 1,
    );
  }
}