import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shwewords/data/datasources/local/dictionary_local_ds.dart';
import 'package:shwewords/data/datasources/remote/dictionary_remote_ds.dart';
import 'package:shwewords/domain/entities/dictionary_metadata.dart';
import 'package:shwewords/domain/entities/download_status.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  DownloadRepositoryImpl(this._local, this._remote);

  final DictionaryLocalDataSource _local;
  final DictionaryRemoteDataSource _remote;

  final _statusController = StreamController<DownloadStatus>.broadcast();

  @override
  Stream<DownloadStatus> get statusStream => _statusController.stream;

  void _emit(DownloadStatus status) {
    if (!_statusController.isClosed) {
      _statusController.add(status);
    }
  }

  @override
  Future<DictionaryMetadata?> fetchRemoteMetadata() =>
      _remote.fetchMetadata();

  @override
  Future<bool> needsDownload({DictionaryMetadata? remoteMetadata}) async {
    if (!await _local.databaseExists()) return true;

    if (remoteMetadata == null) return false;

    final localVersion = await _local.getLocalDbVersion();
    return localVersion != remoteMetadata.version;
  }

  @override
  Future<void> downloadDictionary({DictionaryMetadata? metadata}) async {
    final meta = metadata ?? await fetchRemoteMetadata();
    if (meta == null) {
      _emit(const DownloadStatus.failed(
        message: 'Could not fetch dictionary metadata',
      ));
      return;
    }

    await _local.closeDatabase();
    final dir = await _local.getDocumentsDirectory();

    try {
      await _remote.downloadAndExtract(
        documentsPath: dir.path,
        metadata: meta,
        onStatus: _emit,
      );

      await _local.openDatabase();
      final valid = await _local.validateIntegrity();
      if (!valid) {
        _emit(const DownloadStatus.failed(
          message: 'Database integrity check failed',
        ));
        return;
      }

      await _local.saveLocalDbVersion(meta.version);
      _emit(const DownloadStatus.ready());
    } catch (e) {
      if (kDebugMode) debugPrint('Download error: $e');
    }
  }

  @override
  Future<void> copyBundledDatabase() async {
    _emit(const DownloadStatus.checking());
    await _local.closeDatabase();
    await _local.copyBundledDatabase();
    _emit(const DownloadStatus.validating());
    await _local.openDatabase();
    await _local.saveLocalDbVersion('dev-bundled');
    _emit(const DownloadStatus.ready());
  }

  @override
  Future<void> cancelDownload() {
    _remote.cancelDownload();
    _emit(const DownloadStatus.idle());
    return Future.value();
  }

  @override
  Future<void> deleteLocalDatabase() => _local.deleteDatabase();
}
