import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shwewords/core/constants/hive_boxes.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';

class FavoritesLocalDataSource {
  Future<void> init() async {
    if (!Hive.isBoxOpen(HiveBoxes.favorites)) {
      await Hive.openBox<String>(HiveBoxes.favorites);
    }
    if (!Hive.isBoxOpen(HiveBoxes.recentSearches)) {
      await Hive.openBox<String>(HiveBoxes.recentSearches);
    }
  }

  Box<String> get _favoritesBox => Hive.box<String>(HiveBoxes.favorites);
  Box<String> get _recentBox => Hive.box<String>(HiveBoxes.recentSearches);

  String _favoriteKey(String word, String language) => '$language::$word';

  Future<List<DictionaryEntry>> getFavorites() async {
    final entries = <DictionaryEntry>[];
    for (final value in _favoritesBox.values) {
      try {
        final map = jsonDecode(value) as Map<String, dynamic>;
        entries.add(DictionaryEntry.fromJson(map));
      } catch (_) {
        // skip corrupt entries
      }
    }
    entries.sort((a, b) => a.word.compareTo(b.word));
    return entries;
  }

  Future<bool> isFavorite(String word, String language) async {
    return _favoritesBox.containsKey(_favoriteKey(word, language));
  }

  Future<void> saveFavorite(DictionaryEntry entry) async {
    final key = _favoriteKey(entry.word, entry.language);
    await _favoritesBox.put(key, jsonEncode(entry.toJson()));
  }

  Future<void> removeFavorite(String word, String language) async {
    await _favoritesBox.delete(_favoriteKey(word, language));
  }

  Future<List<String>> getRecentSearches() async {
    return _recentBox.values.toList().reversed.toList();
  }

  Future<void> addRecentSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final existing = await getRecentSearches();
    final updated = [
      trimmed,
      ...existing.where((s) => s != trimmed),
    ].take(20).toList();

    await _recentBox.clear();
    for (var i = updated.length - 1; i >= 0; i--) {
      await _recentBox.add(updated[i]);
    }
  }

  Future<void> clearRecentSearches() async {
    await _recentBox.clear();
  }
}
