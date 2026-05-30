import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/features/settings/providers/settings_provider.dart';

class ShweWordsApp extends ConsumerWidget {
  const ShweWordsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final settings = ref.watch(settingsProvider);
    final fontScale = settings.valueOrNull?.myanmarFontScale ?? 1.2;

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(myanmarFontScale: fontScale),
      darkTheme: AppTheme.dark(myanmarFontScale: fontScale),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
