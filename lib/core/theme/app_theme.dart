import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const _seedColor = Color(0xFF1B7A5E);

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true).textTheme
        : ThemeData.light(useMaterial3: true).textTheme;

    final latin = GoogleFonts.interTextTheme(base);
    final myanmar = GoogleFonts.notoSansMyanmarTextTheme(latin);

    return myanmar;
  }

  static ThemeData light({double myanmarFontScale = 1.0}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      extensions: [
        MyanmarTypography(myanmarFontScale: myanmarFontScale),
      ],
    );
  }

  static ThemeData dark({double myanmarFontScale = 1.0}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      extensions: [
        MyanmarTypography(myanmarFontScale: myanmarFontScale),
      ],
    );
  }
}

class MyanmarTypography extends ThemeExtension<MyanmarTypography> {
  const MyanmarTypography({this.myanmarFontScale = 1.0});

  final double myanmarFontScale;

  TextStyle myanmar(BuildContext context, TextStyle base) {
    return GoogleFonts.notoSansMyanmar(
      fontSize: (base.fontSize ?? 16) * myanmarFontScale,
      fontWeight: base.fontWeight,
      color: base.color,
      height: base.height,
    );
  }

  @override
  MyanmarTypography copyWith({double? myanmarFontScale}) {
    return MyanmarTypography(
      myanmarFontScale: myanmarFontScale ?? this.myanmarFontScale,
    );
  }

  @override
  MyanmarTypography lerp(MyanmarTypography? other, double t) {
    if (other == null) return this;
    return MyanmarTypography(
      myanmarFontScale:
          myanmarFontScale + (other.myanmarFontScale - myanmarFontScale) * t,
    );
  }
}
