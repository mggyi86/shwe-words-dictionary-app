import 'package:shwewords/data/datasources/local/favorites_local_ds.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._local);

  final FavoritesLocalDataSource _local;

  @override
  Future<List<DictionaryEntry>> getFavorites() => _local.getFavorites();

  @override
  Future<bool> isFavorite(String word, String language) =>
      _local.isFavorite(word, language);

  @override
  Future<void> toggleFavorite(DictionaryEntry entry) async {
    final fav = await isFavorite(entry.word, entry.language);
    if (fav) {
      await _local.removeFavorite(entry.word, entry.language);
    } else {
      await _local.saveFavorite(entry);
    }
  }

  @override
  Future<List<String>> getRecentSearches() => _local.getRecentSearches();

  @override
  Future<void> addRecentSearch(String query) => _local.addRecentSearch(query);

  @override
  Future<void> clearRecentSearches() => _local.clearRecentSearches();
}
