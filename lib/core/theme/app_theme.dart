import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/core/theme/myanmar_font_choice.dart';

class AppTheme {
  AppTheme._();

  static const _inputRadius = 12.0;

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true).textTheme
        : ThemeData.light(useMaterial3: true).textTheme;

    return GoogleFonts.interTextTheme(base);
  }

  static ThemeData light({
    double myanmarFontScale = 1.0,
    MyanmarFontChoice myanmarFont = MyanmarFontChoice.roboto,
  }) {
    const brightness = Brightness.light;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.gold,
      onPrimary: AppColors.lightTitle,
      secondary: AppColors.englishTabActiveText,
      onSecondary: Colors.white,
      surface: AppColors.lightScaffold,
      onSurface: AppColors.lightTitle,
      onSurfaceVariant: AppColors.lightMutedText,
      outline: AppColors.gold,
      outlineVariant: AppColors.gold.withValues(alpha: 0.5),
      error: const Color(0xFFB3261E),
      onError: Colors.white,
      tertiary: AppColors.englishTabActive,
      onTertiary: AppColors.englishTabActiveText,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightScaffold,
      textTheme: _buildTextTheme(brightness),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: AppColors.lightScaffold,
        foregroundColor: AppColors.lightTitle,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.gold, size: 22),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSearchFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          side: const BorderSide(color: AppColors.gold, width: 1),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      extensions: [
        MyanmarTypography(
          myanmarFontScale: myanmarFontScale,
          myanmarFont: myanmarFont,
        ),
      ],
    );
  }

  static ThemeData dark({
    double myanmarFontScale = 1.0,
    MyanmarFontChoice myanmarFont = MyanmarFontChoice.roboto,
  }) {
    const brightness = Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.gold,
      onPrimary: AppColors.darkTitle,
      secondary: AppColors.tabActiveGreen,
      onSecondary: AppColors.darkTitle,
      surface: AppColors.darkScaffold,
      onSurface: AppColors.darkTitle,
      onSurfaceVariant: AppColors.grey400,
      outline: AppColors.gold,
      outlineVariant: AppColors.gold.withValues(alpha: 0.5),
      error: const Color(0xFFF2B8B5),
      onError: const Color(0xFF601410),
      tertiary: AppColors.englishTabActiveDark,
      onTertiary: AppColors.tabActiveGreen,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkScaffold,
      textTheme: _buildTextTheme(brightness),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: AppColors.darkScaffold,
        foregroundColor: AppColors.darkTitle,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.gold, size: 22),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSearchFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_inputRadius),
          side: const BorderSide(color: AppColors.gold, width: 1),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      extensions: [
        MyanmarTypography(
          myanmarFontScale: myanmarFontScale,
          myanmarFont: myanmarFont,
        ),
      ],
    );
  }
}

class MyanmarTypography extends ThemeExtension<MyanmarTypography> {
  const MyanmarTypography({
    this.myanmarFontScale = 1.0,
    this.myanmarFont = MyanmarFontChoice.roboto,
  });

  final double myanmarFontScale;
  final MyanmarFontChoice myanmarFont;

  TextStyle myanmar(BuildContext context, TextStyle base) {
    final scaled = base.copyWith(
      fontSize: (base.fontSize ?? 16) * myanmarFontScale,
    );

    return switch (myanmarFont) {
      MyanmarFontChoice.padauk => scaled.copyWith(fontFamily: 'Padauk'),
      MyanmarFontChoice.roboto => GoogleFonts.roboto(textStyle: scaled),
    };
  }

  @override
  MyanmarTypography copyWith({
    double? myanmarFontScale,
    MyanmarFontChoice? myanmarFont,
  }) {
    return MyanmarTypography(
      myanmarFontScale: myanmarFontScale ?? this.myanmarFontScale,
      myanmarFont: myanmarFont ?? this.myanmarFont,
    );
  }

  @override
  MyanmarTypography lerp(MyanmarTypography? other, double t) {
    if (other == null) return this;
    return t < 0.5 ? this : other;
  }
}
