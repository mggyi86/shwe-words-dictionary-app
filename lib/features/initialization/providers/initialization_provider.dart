import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/domain/entities/dictionary_metadata.dart';
import 'package:shwewords/domain/entities/download_status.dart';

final initializationProvider =
    AsyncNotifierProvider<InitializationNotifier, InitializationState>(
  InitializationNotifier.new,
);

class InitializationNotifier extends AsyncNotifier<InitializationState> {
  @override
  Future<InitializationState> build() async {
    return _initialize();
  }

  Future<InitializationState> _initialize() async {
    final dictRepo = ref.read(dictionaryRepositoryProvider);
    final downloadRepo = ref.read(downloadRepositoryProvider);
    final favoritesLocal = ref.read(favoritesLocalDataSourceProvider);

    await favoritesLocal.init();

    final exists = await dictRepo.databaseExists();

    if (!exists) {
      if (kDebugMode && AppConfig.useBundledDatabaseInDebug) {
        await downloadRepo.copyBundledDatabase();
        final count = await dictRepo.getEntryCount();
        return InitializationState.ready(
          dbVersion: 'dev-bundled',
          entryCount: count,
        );
      }

      final metadata = await downloadRepo.fetchRemoteMetadata();
      return InitializationState.needsDownload(remoteMetadata: metadata);
    }

    try {
      await dictRepo.openDatabase();
      final version = await dictRepo.getLocalDbVersion() ?? 'unknown';
      final count = await dictRepo.getEntryCount();

      final remoteMetadata = await downloadRepo.fetchRemoteMetadata();
      if (await downloadRepo.needsDownload(remoteMetadata: remoteMetadata)) {
        return InitializationState.needsDownload(remoteMetadata: remoteMetadata);
      }

      return InitializationState.ready(
        dbVersion: version,
        entryCount: count,
      );
    } catch (e) {
      return InitializationState.error(message: e.toString());
    }
  }

  Future<void> retry() async {
    state = const AsyncLoading();
    state = AsyncData(await _initialize());
  }
}

final downloadStatusProvider = StreamProvider<DownloadStatus>((ref) async* {
  yield const DownloadStatus.idle();
  yield* ref.watch(downloadRepositoryProvider).statusStream;
});

final downloadControllerProvider =
    NotifierProvider<DownloadController, AsyncValue<void>>(
  DownloadController.new,
);

class DownloadController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> startDownload({DictionaryMetadata? metadata}) async {
    state = const AsyncLoading();
    try {
      await ref.read(downloadRepositoryProvider).downloadDictionary(
            metadata: metadata,
          );
      ref.invalidate(initializationProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> useBundledDatabase() async {
    state = const AsyncLoading();
    try {
      await ref.read(downloadRepositoryProvider).copyBundledDatabase();
      ref.invalidate(initializationProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void cancel() {
    ref.read(downloadRepositoryProvider).cancelDownload();
    state = const AsyncData(null);
  }
}
