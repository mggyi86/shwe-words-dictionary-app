import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shwewords/domain/entities/dictionary_metadata.dart';

part 'download_status.freezed.dart';

@freezed
class DownloadStatus with _$DownloadStatus {
  const factory DownloadStatus.idle() = DownloadStatusIdle;

  const factory DownloadStatus.checking() = DownloadStatusChecking;

  const factory DownloadStatus.downloading({
    required int receivedBytes,
    required int totalBytes,
  }) = DownloadStatusDownloading;

  const factory DownloadStatus.decompressing() = DownloadStatusDecompressing;

  const factory DownloadStatus.validating() = DownloadStatusValidating;

  const factory DownloadStatus.ready() = DownloadStatusReady;

  const factory DownloadStatus.failed({
    required String message,
    @Default(true) bool retryable,
  }) = DownloadStatusFailed;
}

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(false) bool wifiOnlyDownload,
    @Default(1.2) double myanmarFontScale,
    @Default('en') String preferredLanguage,
  }) = _AppSettings;
}

@freezed
class InitializationState with _$InitializationState {
  const factory InitializationState.checking() = InitChecking;

  const factory InitializationState.needsDownload({
    DictionaryMetadata? remoteMetadata,
  }) = InitNeedsDownload;

  const factory InitializationState.ready({
    required String dbVersion,
    required int entryCount,
  }) = InitReady;

  const factory InitializationState.error({
    required String message,
  }) = InitError;
}
