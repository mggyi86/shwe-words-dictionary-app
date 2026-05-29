import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/domain/entities/download_status.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() async {
    return ref.read(settingsRepositoryProvider).getSettings();
  }

  Future<void> updateSettings(AppSettings settings) async {
    await ref.read(settingsRepositoryProvider).saveSettings(settings);
    state = AsyncData(settings);
  }

  Future<void> setWifiOnly(bool value) async {
    final current = state.valueOrNull ?? const AppSettings();
    await updateSettings(current.copyWith(wifiOnlyDownload: value));
  }

  Future<void> setMyanmarFontScale(double value) async {
    final current = state.valueOrNull ?? const AppSettings();
    await updateSettings(current.copyWith(myanmarFontScale: value));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    ref.read(themeModeProvider.notifier).state = mode;
  }
}

final connectivityProvider = StreamProvider<bool>((ref) async* {
  // connectivity_plus stream wired in UI widget
  yield true;
});

final dbVersionProvider = FutureProvider<String>((ref) async {
  final version =
      await ref.read(dictionaryRepositoryProvider).getLocalDbVersion();
  return version ?? 'unknown';
});

final entryCountProvider = FutureProvider<int>((ref) async {
  return ref.watch(dictionaryRepositoryProvider).getEntryCount();
});
