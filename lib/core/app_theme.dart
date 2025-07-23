import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const accentColor = Colors.red;

  // color schemes
  static final lightColors = ColorScheme.fromSeed(seedColor: Colors.black);
  static final darkColors = ColorScheme.fromSeed(
    seedColor: Colors.black,
    brightness: Brightness.dark,
    surface: Colors.black,
    onSurface: Colors.white,
  );

  static ThemeData _theme(ColorScheme colors) {
    final typography = Typography.material2021(colorScheme: colors);
    final mainTextTheme = colors.brightness == Brightness.dark
        ? typography.white
        : typography.black;

    return ThemeData.from(colorScheme: colors, useMaterial3: true).copyWith(
      textTheme: GoogleFonts.getTextTheme('Outfit', mainTextTheme),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.outfit(
          color: colors.onSurface,
          fontSize: kDefaultFontSize * 1.75,
          fontWeight: FontWeight.bold,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            colors.surfaceContainerHighest,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: colors.surfaceContainerLow,
      ),
    );
  }

  static final lightTheme = _theme(lightColors);
  static final darkTheme = _theme(darkColors);
}

ColorScheme colorSchemeOf(BuildContext context) {
  return Theme.of(context).colorScheme;
}

double scaledSizeOf(BuildContext context, double size) {
  return MediaQuery.textScalerOf(context).scale(size);
}
