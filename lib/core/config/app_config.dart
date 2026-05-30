/// Application-wide configuration for ShweWords dictionary.
class AppConfig {
  AppConfig._();

  static const appName = 'English Myanmar Dictionary - ShweWords';
  static const appShortName = 'ShweWords';

  // ---------------------------------------------------------------------------
  // Dictionary database source (pick one)
  // ---------------------------------------------------------------------------

  /// How the app obtains [databaseFileName] on first launch.
  ///
  /// - [DictionaryDatabaseSource.downloadAfterInstall]: fetch
  ///   [databaseDownloadUrl] (`dictionary.db.gz`) after the app is installed.
  /// - [DictionaryDatabaseSource.bundledAtBuild]: copy or decompress
  ///   [bundledDatabaseAssetPath] from the APK/IPA at first launch (no download).
  static const dictionaryDatabaseSource =
      DictionaryDatabaseSource.bundledAtBuild;

  /// True when the dictionary is downloaded from [databaseDownloadUrl] on first launch.
  static bool get downloadsDatabaseAfterInstall =>
      dictionaryDatabaseSource == DictionaryDatabaseSource.downloadAfterInstall;

  /// True when the dictionary ships inside the app bundle ([bundledDatabaseAssetPath]).
  static bool get usesBundledDatabaseAtBuild =>
      dictionaryDatabaseSource == DictionaryDatabaseSource.bundledAtBuild;

  /// Asset path when [usesBundledDatabaseAtBuild] is true.
  ///
  /// Add this file under `flutter: assets:` in [pubspec.yaml].
  /// - `dictionary.db` — copied directly to app documents.
  /// - `dictionary.db.gz` — decompressed on first launch (smaller install size).
  ///
  /// Example: copy project-root `dictionary.db.gz` to `assets/data/dictionary.db.gz`.
  static const bundledDatabaseAssetPath = 'assets/dev/dictionary.db';

  /// True when [bundledDatabaseAssetPath] ends with `.gz`.
  static bool get bundledDatabaseIsGzip =>
      bundledDatabaseAssetPath.endsWith('.gz');

  // ---------------------------------------------------------------------------
  // Remote download (downloadAfterInstall)
  // ---------------------------------------------------------------------------

  /// Direct URLs for dictionary assets (GitHub user-attachments or release assets).
  static const metadataUrl =
      'https://github.com/user-attachments/files/28418064/metadata.json';

  /// Gzip-compressed SQLite dictionary (`dictionary.db.gz`).
  static const databaseDownloadUrl =
      'https://github.com/user-attachments/files/28418062/dictionary.db.gz';

  static const databaseFileName = 'dictionary.db';
  static const databaseStagingFileName = 'dictionary.db.new';
  static const databaseBackupFileName = 'dictionary.db.bak';
  static const databaseGzipFileName = 'dictionary.db.gz';
  static const databaseTempGzipFileName = 'dictionary.db.gz.tmp';

  static const searchDebounceMs = 250;
  static const searchPageSize = 30;
  static const searchCacheSize = 20;
  static const defaultLanguage = 'en';

  static const downloadMaxRetries = 3;
  static const downloadRetryDelayMs = 2000;
}

/// First-launch dictionary provisioning strategy.
enum DictionaryDatabaseSource {
  /// Download `dictionary.db.gz` from [AppConfig.databaseDownloadUrl] after install.
  downloadAfterInstall,

  /// Ship `dictionary.db` or `dictionary.db.gz` in the app bundle at build time.
  bundledAtBuild,
}
