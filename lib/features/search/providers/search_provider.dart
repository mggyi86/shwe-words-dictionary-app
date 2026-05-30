import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/domain/entities/search_result.dart';

final searchModeProvider = StateProvider<SearchMode>((ref) => SearchMode.english);

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchControllerProvider =
    AsyncNotifierProvider<SearchController, SearchPage>(
  SearchController.new,
);

class SearchController extends AsyncNotifier<SearchPage> {
  Timer? _debounce;
  int _requestId = 0;

  @override
  Future<SearchPage> build() async {
    ref.onDispose(() => _debounce?.cancel());
    return const SearchPage(results: [], hasMore: false, offset: 0);
  }

  void cancelDebounce() {
    _debounce?.cancel();
    _debounce = null;
  }

  void updateQuery(String query) {
    ref.read(searchQueryProvider.notifier).state = query;
    cancelDebounce();
    _debounce = Timer(
      const Duration(milliseconds: AppConfig.searchDebounceMs),
      () => search(query: query, offset: 0),
    );
  }

  Future<void> search({
    required String query,
    int offset = 0,
    SearchMode? modeOverride,
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      state = const AsyncData(SearchPage(results: [], hasMore: false, offset: 0));
      return;
    }

    final currentRequest = ++_requestId;
    state = const AsyncLoading();

    try {
      final resolvedSearchMode = modeOverride ??
          ref.read(searchModeProvider.notifier).state;
      final repo = ref.read(searchRepositoryProvider);
      final page = await repo.search(
        trimmed,
        searchMode: resolvedSearchMode,
        language: AppConfig.defaultLanguage,
        limit: AppConfig.searchPageSize,
        offset: offset,
      );

      if (currentRequest != _requestId) return;

      if (offset == 0) {
        await ref.read(favoritesRepositoryProvider).addRecentSearch(trimmed);
      }

      state = AsyncData(page);
    } catch (e, st) {
      if (currentRequest == _requestId) {
        state = AsyncError(e, st);
      }
    }
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore) return;

    final query = ref.read(searchQueryProvider);
    final nextOffset = current.offset + current.results.length;
    final searchMode = ref.read(searchModeProvider.notifier).state;

    try {
      final repo = ref.read(searchRepositoryProvider);
      final page = await repo.search(
        query,
        searchMode: searchMode,
        language: AppConfig.defaultLanguage,
        limit: AppConfig.searchPageSize,
        offset: nextOffset,
      );

      state = AsyncData(SearchPage(
        results: [...current.results, ...page.results],
        hasMore: page.hasMore,
        offset: nextOffset,
      ));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void clear() {
    cancelDebounce();
    ref.read(searchQueryProvider.notifier).state = '';
    state = const AsyncData(SearchPage(results: [], hasMore: false, offset: 0));
  }
}

final recentSearchesProvider = FutureProvider<List<String>>((ref) {
  return ref.watch(favoritesRepositoryProvider).getRecentSearches();
});

final favoritesProvider = FutureProvider((ref) {
  return ref.watch(favoritesRepositoryProvider).getFavorites();
});

final favoriteStatusProvider =
    FutureProvider.family<bool, ({String word, String language})>((ref, key) {
  return ref
      .watch(favoritesRepositoryProvider)
      .isFavorite(key.word, key.language);
});
