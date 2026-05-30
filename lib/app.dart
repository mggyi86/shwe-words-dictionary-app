import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/core/theme/myanmar_font_choice.dart';
import 'package:shwewords/features/settings/providers/settings_provider.dart';

class ShweWordsApp extends ConsumerWidget {
  const ShweWordsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final settings = ref.watch(settingsProvider);
    final fontScale = settings.valueOrNull?.myanmarFontScale ?? 1.0;
    final myanmarFont = settings.valueOrNull?.myanmarFont ?? MyanmarFontChoice.roboto;

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(
        myanmarFontScale: fontScale,
        myanmarFont: myanmarFont,
      ),
      darkTheme: AppTheme.dark(
        myanmarFontScale: fontScale,
        myanmarFont: myanmarFont,
      ),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
