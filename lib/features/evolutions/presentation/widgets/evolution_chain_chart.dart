import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'evolution_method_chart.dart';
import 'pokemon_chart.dart';

class EvolutionChainChart extends StatelessWidget {
  const EvolutionChainChart({
    super.key,
    required this.firstName,
    required this.firstNumber,
    required this.secondName,
    required this.secondNumber,
    required this.evolutionDescription,
    required this.details,
    required this.sprites,
  });

  final String firstName;
  final int firstNumber;
  final String secondName;
  final int secondNumber;
  final String evolutionDescription;
  final String details;
  final List<String> sprites;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PokemonChart(name: firstName, number: firstNumber),
        EvolutionMethodChart(
          title: evolutionDescription,
          subtitle: details,
          sprites: sprites,
        ),
        PokemonChart(name: secondName, number: secondNumber),
      ],
    ).animate().fade();
  }
}