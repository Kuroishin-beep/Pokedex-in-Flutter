import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/extensions/string_extensions.dart';
import '../constants/pokedex_spacing.dart';
import '../extensions/design_string_extensions.dart';

class BadgeType extends StatelessWidget {
  const BadgeType({
    super.key,
    required this.type,
    this.diameter = 0.0,
    this.diameterPadding = 0.0,
  });

  final String type;
  final double diameter;
  final double diameterPadding;

  @override
  Widget build(BuildContext context) {
    return diameter == 0.0 ? _buildTextBadge(context) : _buildCircular();
  }

  Widget _buildTextBadge(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type.pokemonColor.primary,
        borderRadius: BorderRadius.circular(PokedexSpacing.kM),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: PokedexSpacing.kS,
        vertical: PokedexSpacing.kXS,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'icons/$type.svg'.asset(),
            height: PokedexSpacing.kM,
            width: PokedexSpacing.kM,
          ),
          const SizedBox(width: PokedexSpacing.kS),
          Text(
            type.capitalize(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCircular() {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: type.pokemonColor.primary,
        borderRadius: BorderRadius.circular(diameter / 2),
      ),
      padding: EdgeInsets.all(diameterPadding),
      child: SvgPicture.asset('icons/$type.svg'.asset()),
    );
  }
}
