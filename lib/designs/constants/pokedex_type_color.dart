import 'package:flutter/material.dart';

enum PokedexTypeColor {
  bug(Color(0xFFA6B91E), Color(0xFFB6D21C)), // Primary color slightly altered
  dark(Color(0xFF705746), Color(0xFF707070)), //  Secondary color adjusted
  dragon(Color(0xFF0062E0), Color(0xFF53A4EB)),
  electric(Color(0xFFF7D02C), Color(0xFFF8E46E)), // Adjusted for more electric yellow
  fairy(Color(0xFFD685AD), Color(0xFFE5A7B5)),
  fighting(Color(0xFFC12239), Color(0xFFD75144)), // More accurate fighting color
  fire(Color(0xFFEE8130), Color(0xFFF7933B)),
  flying(Color(0xFFA890F0), Color(0xFFB1A2E6)), // Slight color adj
  ghost(Color(0xFF735797), Color(0xFF8666A9)),
  grass(Color(0xFF7AC74C), Color(0xFF9DD679)),
  ground(Color(0xFFE2BF65), Color(0xFFF1DA71)),
  ice(Color(0xFF96D9D6), Color(0xFFB2E3E2)),
  normal(Color(0xFFA8A77A), Color(0xFFB9B8A3)),
  poison(Color(0xFFA33EA1), Color(0xFFB570C5)), // Adjusted poison color
  psychic(Color(0xFFF95587), Color(0xFFF8869E)), // Adjusted for more pink
  rock(Color(0xFFB6A136), Color(0xFFC8B54C)),
  steel(Color(0xFFB7B7CE), Color(0xFFCDCDD8)),// adjusted steel color
  water(Color(0xFF6390F0), Color(0xFF78A4F4)),
  shadow(Color(0xFF5116A4), Color(0xFF855BBF)), //Kept original
  stellar(Color(0xFF00B7A6), Color(0xFF00C5B0)), //Kept original
  unknown(Color(0xFF333D33), Color(0xFF707770)); //Kept original

  final Color primary;
  final Color secondary;
  const PokedexTypeColor(this.primary, this.secondary);
}