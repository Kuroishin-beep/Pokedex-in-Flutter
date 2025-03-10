import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';

import '../../../../designs/components/stat_line.dart';
import '../../../../designs/constants/pokedex_spacing.dart';
import '../../../../designs/constants/pokedex_theme_data.dart';
import '../../../../shared/extensions/pokemon_type_extensions.dart';
import '../../../../shared/extensions/strings_extensions.dart';
import '../../domain/entities/stats_value_entity.dart';
import '../cubit/stats_cubit.dart';
import '../strings/stats_strings.dart';
import 'stats_types_list.dart';

class StatsSuccess extends StatefulWidget {
  const StatsSuccess({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  State<StatsSuccess> createState() => _StatsSuccessState();
}

class _StatsSuccessState extends State<StatsSuccess> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = (context.watch<StatsCubit>().state as StatsSuccessState).data;
    final primaryColor = stats.pokemon.types.first.color.primary;

    final textTheme = Theme.of(context).textTheme;
    final sectionTheme = textTheme.titleMedium?.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.bold,
    );
    final multiplers = stats.multiplers.toList();
    final hasImmune = multiplers.any((element) => element.second == 0.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: PokedexSpacing.kXL,
        right: PokedexSpacing.kXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StatsStrings.baseStats, style: sectionTheme),
          const SizedBox(height: PokedexSpacing.kL),
          if (stats.statsMap['hp'] != null) ...{
            _buildStat(stats.statsMap['hp']!, StatsStrings.hp, primaryColor,
                stats.minStat)
          },
          if (stats.statsMap['attack'] != null) ...{
            _buildStat(stats.statsMap['attack']!, StatsStrings.attack,
                primaryColor, stats.minStat)
          },
          if (stats.statsMap['defense'] != null) ...{
            _buildStat(stats.statsMap['defense']!, StatsStrings.defense,
                primaryColor, stats.minStat)
          },
          if (stats.statsMap['special-attack'] != null) ...{
            _buildStat(stats.statsMap['special-attack']!,
                StatsStrings.specialAttack, primaryColor, stats.minStat)
          },
          if (stats.statsMap['special-defense'] != null) ...{
            _buildStat(stats.statsMap['special-defense']!,
                StatsStrings.specialDefense, primaryColor, stats.minStat)
          },
          if (stats.statsMap['speed'] != null) ...{
            _buildStat(stats.statsMap['speed']!, StatsStrings.speed,
                primaryColor, stats.minStat)
          },
          _buildStatTotalRow(textTheme, stats.summation),
          const SizedBox(height: PokedexSpacing.kL),
          Text(
            StatsStrings.description,
            style: textTheme.labelSmall
                ?.copyWith(color: PokedexThemeData.textGrey),
          ),
          const SizedBox(height: PokedexSpacing.kL),
          Text(StatsStrings.typeEffectiveness, style: sectionTheme),
          const SizedBox(height: PokedexSpacing.kM),
          Text(
              '${StatsStrings.typeEffectivenessOnType} ${stats.pokemon.name.capitalize()}',
              style: textTheme.bodyLarge
                  ?.copyWith(color: PokedexThemeData.textGrey)),
          const SizedBox(height: PokedexSpacing.kM),
          StatsTypesList(
            defenses: stats.multiplers.toList(),
          ),
          if (hasImmune) ...{
            Text(
              StatsStrings.immune,
              style: textTheme.labelSmall
                  ?.copyWith(color: PokedexThemeData.textGrey),
            ),
            const SizedBox(height: PokedexSpacing.kM),
          },
          const SizedBox(height: PokedexSpacing.kXL),
        ],
      ),
    );
  }

  Widget _buildStat(StatsValueEntity statsValueEntity, String title,
      Color color, int totalValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: PokedexSpacing.kM),
      child: StatLine(
        color: color,
        title: title,
        value: statsValueEntity.value,
        minValue: statsValueEntity.minValue,
        maxValue: statsValueEntity.maxValue,
        totalValue: totalValue,
      ),
    );
  }

  Widget _buildStatTotalRow(TextTheme textTheme, int total) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            StatsStrings.total,
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            total.toString(),
            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
          flex: 5,
          child: Center(
            child: SizedBox.shrink(),
          ),
        ),
        Expanded(
          child: Text(
            StatsStrings.min,
            style: textTheme.labelLarge,
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Text(
            StatsStrings.max,
            style: textTheme.labelLarge,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}