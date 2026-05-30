import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/errors/app_exception.dart';
import 'package:shwewords/domain/entities/dictionary_metadata.dart';
import 'package:shwewords/domain/entities/download_status.dart';

class DictionaryRemoteDataSource {
  DictionaryRemoteDataSource({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;
  CancelToken? _cancelToken;

  Future<DictionaryMetadata?> fetchMetadata({String? url}) async {
    try {
      final response = await _dio.get<String>(
        url ?? AppConfig.metadataUrl,
        options: Options(responseType: ResponseType.plain),
      );
      final map = jsonDecode(response.data!) as Map<String, dynamic>;
      return DictionaryMetadata.fromJson(map);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint('Metadata fetch failed: $e');
      }
      return null;
    }
  }

  Future<void> downloadAndExtract({
    required String documentsPath,
    required DictionaryMetadata metadata,
    required void Function(DownloadStatus status) onStatus,
    String? downloadUrl,
    String databaseFileName = AppConfig.databaseFileName,
  }) async {
    _cancelToken = CancelToken();
    final dbPath = p.join(documentsPath, databaseFileName);
    final gzPath = p.join(documentsPath, AppConfig.databaseTempGzipFileName);
    final gzFile = File(gzPath);

    try {
      onStatus(const DownloadStatus.checking());

      final url = downloadUrl ?? AppConfig.databaseDownloadUrl;
      var received = 0;
      if (gzFile.existsSync()) {
        received = await gzFile.length();
      }

      onStatus(DownloadStatus.downloading(
        receivedBytes: received,
        totalBytes: metadata.size,
      ));

      await _dio.download(
        url,
        gzPath,
        cancelToken: _cancelToken,
        options: Options(
          headers: received > 0 ? {'Range': 'bytes=$received-'} : null,
          receiveTimeout: const Duration(minutes: 30),
        ),
        onReceiveProgress: (count, total) {
          final effectiveTotal = total > 0 ? total : metadata.size;
          onStatus(DownloadStatus.downloading(
            receivedBytes: count,
            totalBytes: effectiveTotal,
          ));
        },
      );

      // Validate gzip checksum before decompressing.
      final gzDigest = sha256.convert(await gzFile.readAsBytes());
      if (gzDigest.toString() != metadata.sha256) {
        throw DownloadException(
          'Checksum mismatch: expected ${metadata.sha256}, got $gzDigest',
        );
      }

      onStatus(const DownloadStatus.decompressing());
      await _decompressGzip(gzPath, dbPath);

      onStatus(const DownloadStatus.validating());
      final valid = await _validateDatabase(dbPath);
      if (!valid) {
        throw const DownloadException('Database validation failed');
      }

      if (gzFile.existsSync()) {
        await gzFile.delete();
      }

      onStatus(const DownloadStatus.ready());
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        onStatus(const DownloadStatus.idle());
        return;
      }
      onStatus(DownloadStatus.failed(
        message: e.message ?? 'Download failed',
      ));
      rethrow;
    } catch (e) {
      onStatus(DownloadStatus.failed(message: e.toString()));
      rethrow;
    }
  }

  Future<void> _decompressGzip(String gzPath, String dbPath) async {
    final gzBytes = await File(gzPath).readAsBytes();
    final decoded = GZipDecoder().decodeBytes(gzBytes);
    final dbFile = File(dbPath);
    if (dbFile.existsSync()) await dbFile.delete();
    await dbFile.writeAsBytes(decoded, flush: true);
  }

  Future<bool> _validateDatabase(String dbPath) async {
    final dbFile = File(dbPath);
    if (!dbFile.existsSync()) return false;
    return dbFile.lengthSync() > 0;
  }

  void cancelDownload() {
    _cancelToken?.cancel('User cancelled');
    _cancelToken = null;
  }
}
