import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/theme/app_colors.dart';
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
  final _focusNode = FocusNode();

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
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = ref.watch(searchControllerProvider);
    final searchMode = ref.watch(searchModeProvider);
    final recentAsync = ref.watch(recentSearchesProvider);
    final isWide = MediaQuery.sizeOf(context).width >= 840;
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(brightness),
      body: SafeArea(
        child: isWide
            ? _buildWideLayout(searchAsync, searchMode, recentAsync)
            : _buildNarrowLayout(searchAsync, searchMode, recentAsync),
      ),
    );
  }

  Widget _buildNarrowLayout(
    AsyncValue<SearchPage> searchAsync,
    SearchMode searchMode,
    AsyncValue<List<String>> recentAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBrandedHeader(),
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
              _buildBrandedHeader(),
              _buildSearchHeader(searchMode),
              Expanded(child: _buildResults(searchAsync, recentAsync)),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          color: AppColors.goldBorder(Theme.of(context).brightness)
              .withValues(alpha: 0.35),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Select a word to view details',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.mutedText(Theme.of(context).brightness),
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandedHeader() {
    final brightness = Theme.of(context).brightness;
    final gold = AppColors.goldBorder(brightness);
    final titleColor = AppColors.primaryText(brightness);
    final subtitleColor = AppColors.mutedText(brightness);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
      child: Row(
        children: [
          const AppLogo(
            variant: AppLogoVariant.icon,
            height: 36,
            width: 36,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: titleColor,
                      height: 1.25,
                      fontSize: 14,
                    ),
                children: [
                  TextSpan(
                    text: AppConfig.appShortName,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: ' English Myanmar Dictionary',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const OfflineIndicator(),
          IconButton(
            icon: const Icon(Icons.history_rounded),
            color: gold,
            tooltip: 'History & Favorites',
            onPressed: () => context.push(AppRoutes.history),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: gold,
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader(SearchMode searchMode) {
    final brightness = Theme.of(context).brightness;
    final gold = AppColors.goldBorder(brightness);
    final fill = AppColors.searchFill(brightness);
    final textColor = AppColors.primaryText(brightness);
    final iconColor = AppColors.mutedText(brightness);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: gold, width: 1),
              boxShadow: brightness == Brightness.light
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
              decoration: InputDecoration(
                hintText: _hintForMode(searchMode),
                hintStyle: TextStyle(color: iconColor.withValues(alpha: 0.8)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                prefixIcon: Icon(Icons.search_rounded, color: iconColor, size: 22),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close_rounded, color: iconColor, size: 20),
                        onPressed: () {
                          _controller.clear();
                          ref.read(searchControllerProvider.notifier).clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
                ref.read(searchControllerProvider.notifier).updateQuery(value);
              },
              onSubmitted: (value) {
                ref.read(searchControllerProvider.notifier).search(query: value);
              },
            ),
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
      loading: () => Center(
        child: CircularProgressIndicator(
          color: AppColors.goldBorder(Theme.of(context).brightness),
        ),
      ),
      error: (e, _) => Center(child: Text('Search error: $e')),
      data: (page) {
        if (page.results.isEmpty) {
          return _buildEmptyState(recentAsync);
        }
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          itemCount: page.results.length + (page.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= page.results.length) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.goldBorder(Theme.of(context).brightness),
                  ),
                ),
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
    final muted = AppColors.mutedText(Theme.of(context).brightness);

    if (query.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 48, color: muted),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: muted),
            ),
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: muted),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Recent searches',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primaryText(Theme.of(context).brightness),
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recent.map((term) {
                return ActionChip(
                  label: Text(term),
                  side: BorderSide(
                    color: AppColors.goldBorder(Theme.of(context).brightness),
                  ),
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
