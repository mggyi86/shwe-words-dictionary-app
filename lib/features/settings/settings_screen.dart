import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/features/initialization/providers/initialization_provider.dart';
import 'package:shwewords/features/settings/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final dbVersionAsync = ref.watch(dbVersionProvider);
    final entryCountAsync = ref.watch(entryCountProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (settings) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Theme'),
                subtitle: Text(_themeLabel(themeMode)),
              ),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(value: ThemeMode.system, label: Text('System')),
                  ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                  ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                ],
                selected: {themeMode},
                onSelectionChanged: (set) {
                  ref.read(themeModeProvider.notifier).state = set.first;
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Wi-Fi only downloads'),
                subtitle: const Text('Download dictionary updates on Wi-Fi only'),
                value: settings.wifiOnlyDownload,
                onChanged: (v) =>
                    ref.read(settingsProvider.notifier).setWifiOnly(v),
              ),
              ListTile(
                title: const Text('Myanmar font size'),
                subtitle: Slider(
                  value: settings.myanmarFontScale,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7,
                  label: settings.myanmarFontScale.toStringAsFixed(1),
                  onChanged: (v) => ref
                      .read(settingsProvider.notifier)
                      .setMyanmarFontScale(v),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Dictionary version'),
                subtitle: dbVersionAsync.when(
                  data: (v) => Text(v),
                  loading: () => const Text('Loading...'),
                  error: (_, __) => const Text('Unknown'),
                ),
              ),
              ListTile(
                title: const Text('Entry count'),
                subtitle: entryCountAsync.when(
                  data: (c) => Text('$c words'),
                  loading: () => const Text('Loading...'),
                  error: (_, __) => const Text('Unknown'),
                ),
              ),
              ListTile(
                title: const Text('Re-download dictionary'),
                subtitle: const Text('Fetch latest database from GitHub Releases'),
                trailing: const Icon(Icons.download),
                onTap: () async {
                  await ref.read(downloadRepositoryProvider).deleteLocalDatabase();
                  ref.invalidate(initializationProvider);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              if (kDebugMode && AppConfig.useBundledDatabaseInDebug)
                ListTile(
                  title: const Text('Use bundled database'),
                  subtitle: const Text('Debug: copy from app assets'),
                  onTap: () => ref
                      .read(downloadControllerProvider.notifier)
                      .useBundledDatabase(),
                ),
              const Divider(),
              const ListTile(
                title: Text('About'),
                subtitle: Text(AppConfig.appName),
              ),
              ListTile(
                title: const Text('Version'),
                subtitle: Text('${AppConfig.appShortName} 1.0.0'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _themeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'Follow system',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }
}
