import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shwewords/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true).textTheme
        : ThemeData.light(useMaterial3: true).textTheme;

    final latin = GoogleFonts.interTextTheme(base);
    return GoogleFonts.notoSansMyanmarTextTheme(latin);
  }

  static ThemeData light({double myanmarFontScale = 1.0}) {
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
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.gold, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
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
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.gold, width: 1),
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
    const brightness = Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.goldDark,
      onPrimary: AppColors.darkTitle,
      secondary: AppColors.englishTabActiveTextDark,
      onSecondary: AppColors.darkTitle,
      surface: AppColors.darkScaffold,
      onSurface: AppColors.darkTitle,
      onSurfaceVariant: AppColors.darkMutedText,
      outline: AppColors.goldDark,
      outlineVariant: AppColors.goldDark.withValues(alpha: 0.5),
      error: const Color(0xFFF2B8B5),
      onError: const Color(0xFF601410),
      tertiary: AppColors.englishTabActiveDark,
      onTertiary: AppColors.englishTabActiveTextDark,
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
      iconTheme: const IconThemeData(color: AppColors.goldDark, size: 22),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSearchFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.goldDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.goldDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.goldDark, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.goldDark, width: 1),
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
