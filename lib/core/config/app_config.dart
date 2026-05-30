/// Application-wide configuration for ShweWords dictionary.
class AppConfig {
  AppConfig._();

  static const appName = 'English Myanmar Dictionary - ShweWords';
  static const appShortName = 'ShweWords';

  /// Direct URLs for dictionary assets (GitHub user-attachments or release assets).
  static const metadataUrl =
      'https://github.com/user-attachments/files/28418064/metadata.json';
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

  /// When true, copies bundled dev database instead of downloading.
  static const useBundledDatabaseInDebug = true;

  static const bundledDatabaseAssetPath = 'assets/dev/dictionary.db';

  static const downloadMaxRetries = 3;
  static const downloadRetryDelayMs = 2000;
}
