import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/widgets/app_logo.dart';
import 'package:shwewords/domain/entities/search_result.dart';
import 'package:shwewords/features/search/providers/search_provider.dart';
import 'package:shwewords/features/search/widgets/offline_indicator.dart';
import 'package:shwewords/features/search/widgets/search_mode_toggle.dart';
import 'package:shwewords/features/search/widgets/search_result_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(searchControllerProvider);
    final searchMode = ref.watch(searchModeProvider);
    final recentAsync = ref.watch(recentSearchesProvider);
    final isWide = MediaQuery.sizeOf(context).width >= 840;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(
              variant: AppLogoVariant.icon,
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 10),
            const Text(AppConfig.appShortName),
          ],
        ),
        actions: [
          const OfflineIndicator(),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History & Favorites',
            onPressed: () => context.push(AppRoutes.history),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: isWide ? _buildWideLayout(searchAsync, searchMode, recentAsync) : _buildNarrowLayout(searchAsync, searchMode, recentAsync),
    );
  }

  Widget _buildNarrowLayout(
    AsyncValue<SearchPage> searchAsync,
    SearchMode searchMode,
    AsyncValue<List<String>> recentAsync,
  ) {
    return Column(
      children: [
        _buildSearchHeader(searchMode),
        Expanded(child: _buildResults(searchAsync, recentAsync)),
      ],
    );
  }

  Widget _buildWideLayout(
    AsyncValue<SearchPage> searchAsync,
    SearchMode searchMode,
    AsyncValue<List<String>> recentAsync,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 400,
          child: Column(
            children: [
              _buildSearchHeader(searchMode),
              Expanded(child: _buildResults(searchAsync, recentAsync)),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: Center(
            child: Text(
              'Select a word to view details',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchHeader(SearchMode searchMode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          SearchBar(
            controller: _controller,
            hintText: _hintForMode(searchMode),
            leading: const Icon(Icons.search),
            trailing: [
              if (_controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    ref.read(searchControllerProvider.notifier).clear();
                    setState(() {});
                  },
                ),
            ],
            onChanged: (value) {
              setState(() {});
              ref.read(searchControllerProvider.notifier).updateQuery(value);
            },
            onSubmitted: (value) {
              ref.read(searchControllerProvider.notifier).search(query: value);
            },
          ),
          const SizedBox(height: 12),
          SearchModeToggle(
            mode: searchMode,
            onChanged: (mode) {
              ref.read(searchModeProvider.notifier).state = mode;
              final query = ref.read(searchQueryProvider);
              if (query.isNotEmpty) {
                ref.read(searchControllerProvider.notifier).search(
                      query: query,
                      modeOverride: mode,
                    );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResults(
    AsyncValue<SearchPage> searchAsync,
    AsyncValue<List<String>> recentAsync,
  ) {
    return searchAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Search error: $e')),
      data: (page) {
        if (page.results.isEmpty) {
          return _buildEmptyState(recentAsync);
        }
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: page.results.length + (page.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= page.results.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final result = page.results[index];
            return SearchResultTile(
              result: result,
              onTap: () => context.push('/word/${result.id}'),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(AsyncValue<List<String>> recentAsync) {
    final query = ref.watch(searchQueryProvider);

    if (query.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off,
                size: 48,
                color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            const Text('No results found'),
          ],
        ),
      );
    }

    return recentAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (recent) {
        if (recent.isEmpty) {
          return Center(
            child: Text(
              'Search English, Myanmar, or synonyms',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Recent searches',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recent.map((term) {
                return ActionChip(
                  label: Text(term),
                  onPressed: () {
                    _controller.text = term;
                    ref.read(searchControllerProvider.notifier).search(
                          query: term,
                        );
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  String _hintForMode(SearchMode mode) {
    return switch (mode) {
      SearchMode.english => 'Search English words...',
      SearchMode.myanmar => 'Search Myanmar meanings...',
      SearchMode.synonym => 'Search synonyms...',
    };
  }
}
