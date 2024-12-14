import 'package:flutter/material.dart';
import '../constants/pokedex_spacing.dart';

class CircularMatrix extends StatelessWidget {
  const CircularMatrix({
    super.key,
    this.rows = 1,
    this.columns = 1,
    this.size = PokedexSpacing.kS,
    this.spacingBetween = PokedexSpacing.kS,
  });

  final int rows;
  final int columns;
  final double size;
  final double spacingBetween;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: List.generate(
          10,
              (index) => Colors.white.withOpacity((index / 10) * 1.0),
        ),
      ).createShader(bounds),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          rows,
              (rowIndex) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              columns,
                  (colIndex) => Padding(
                padding: EdgeInsets.only(
                  right: spacingBetween,
                  bottom: spacingBetween,
                ),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size / 2),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
