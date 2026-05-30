import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/dictionary_metadata.dart';
import 'package:shwewords/domain/entities/download_status.dart';
import 'package:shwewords/domain/entities/search_result.dart';

abstract class DictionaryRepository {
  Future<bool> databaseExists();
  Future<String> getDatabasePath();
  Future<String?> getLocalDbVersion();
  Future<void> saveLocalDbVersion(String version);
  Future<int> getEntryCount();
  Future<void> openDatabase();
  Future<void> closeDatabase();
}

abstract class SearchRepository {
  Future<DictionaryEntry?> exactLookup(String word, {String language = 'en'});
  Future<Map<String, int>> lookupEntryIds(
    Iterable<String> words, {
    String language = 'en',
  });
  Future<SearchPage> search(
    String query, {
    required SearchMode searchMode,
    String language = 'en',
    int limit = 30,
    int offset = 0,
  });
  Future<DictionaryEntry?> getEntryById(int id);
}

abstract class DownloadRepository {
  Stream<DownloadStatus> get statusStream;
  Future<DictionaryMetadata?> fetchRemoteMetadata();
  Future<bool> needsDownload({DictionaryMetadata? remoteMetadata});
  Future<void> downloadDictionary({DictionaryMetadata? metadata});
  Future<void> copyBundledDatabase();
  Future<void> cancelDownload();
  Future<void> deleteLocalDatabase();
}

abstract class FavoritesRepository {
  Future<List<DictionaryEntry>> getFavorites();
  Future<bool> isFavorite(String word, String language);
  Future<void> toggleFavorite(DictionaryEntry entry);
  Future<List<String>> getRecentSearches();
  Future<void> addRecentSearch(String query);
  Future<void> clearRecentSearches();
}

abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
}
