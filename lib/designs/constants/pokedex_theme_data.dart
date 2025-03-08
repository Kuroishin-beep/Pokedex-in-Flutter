import 'package:flutter/material.dart';

abstract class PokedexThemeData {
  static ThemeData get pokedexTheme => ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: _notionColorScheme,
  );

  // Grey level
  static Color greyLevelLight = const Color(0xFFF2F2F2);
  static Color greyLevelMedium = const Color(0xFFE2E2E2);

  // Others
  static Color backgroundDetails = const Color(0xFF1E293B); // Dark Blue
  static Color textWhite = const Color(0xFFFFFFFF);
  static Color textBlack = const Color(0xFF17171B);
  static Color textGrey = const Color(0xFF747476);
  static Color textNumber = const Color(0xFF17171B).withOpacity(0.6);
}

const _notionColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1E40AF), // Deep Blue
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF93C5FD), // Light Blue
  onPrimaryContainer: Color(0xFF0C4A6E),
  secondary: Color(0xFFFACC15), // Yellow
  onSecondary: Color(0xFF423107),
  secondaryContainer: Color(0xFFFEF08A), // Light Yellow
  onSecondaryContainer: Color(0xFF5E4C0D),
  tertiary: Color(0xFF0EA5E9), // Sky Blue
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF7DD3FC),
  onTertiaryContainer: Color(0xFF082F49),
  error: Color(0xFFDC2626),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFEE2E2),
  onErrorContainer: Color(0xFF7F1D1D),
  outline: Color(0xFF64748B),
  surface: Color(0xFFF8FAFC),
  onSurface: Color(0xFF1E293B),
  surfaceContainerHighest: Color(0xFFE2E8F0),
  onSurfaceVariant: Color(0xFF475569),
  inverseSurface: Color(0xFF1E293B),
  onInverseSurface: Color(0xFFF1F5F9),
  inversePrimary: Color(0xFFBFDBFE),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF2563EB),
  outlineVariant: Color(0xFFCBD5E1),
  scrim: Color(0xFF000000),
);