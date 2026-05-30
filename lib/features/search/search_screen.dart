import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkScaffold : const Color(0xFFF4F7F4),
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
          color: AppColors.gold.withValues(alpha: 0.35),
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

  Widget _buildHeaderLogo() {
    const size = 48.0;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/app_icon.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          cacheWidth: (size * dpr).round(),
          cacheHeight: (size * dpr).round(),
        ),
      ),
    );
  }

  Widget _buildBrandedHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderLogo(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      AppConfig.appShortName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    Text(
                      ' English Myanmar',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Dictionary',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
          const OfflineIndicator(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.history_rounded),
                color: const Color(0xFFD4AF37),
                tooltip: 'History & Favorites',
                onPressed: () => context.push(AppRoutes.history),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                color: const Color(0xFFD4AF37),
                tooltip: 'Settings',
                onPressed: () => context.push(AppRoutes.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader(SearchMode searchMode) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchIconColor = isDark ? Colors.grey[400]! : Colors.black54;
    final hintColor = isDark ? Colors.grey[400]! : Colors.black54;
    final inputTextColor = isDark ? Colors.white : Colors.black87;
    final query = ref.watch(searchQueryProvider);
    final myanmarTypography = Theme.of(context).extension<MyanmarTypography>();
    final baseFieldStyle = TextStyle(color: inputTextColor, fontSize: 16);
    final fieldStyle = MyanmarText.containsMyanmar(query)
        ? myanmarTypography?.myanmar(context, baseFieldStyle) ?? baseFieldStyle
        : baseFieldStyle;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C20) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isDark
                  ? Border.all(
                      color: AppColors.gold.withValues(alpha: 0.3),
                    )
                  : null,
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: fieldStyle,
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                fillColor: Colors.transparent,
                hintText: _hintForMode(searchMode),
                hintStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                prefixIcon: Icon(Icons.search, color: searchIconColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: searchIconColor),
                  onPressed: () {
                    _controller.clear();
                    ref.read(searchControllerProvider.notifier).clear();
                    setState(() {});
                  },
                ),
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
          const SizedBox(height: 16),
          SearchModeToggle(
            mode: searchMode,
            onChanged: (mode) {
              ref.read(searchControllerProvider.notifier).cancelDebounce();
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
          const SizedBox(height: 16),
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
          color: AppColors.gold,
        ),
      ),
      error: (e, _) => Center(child: Text('Search error: $e')),
      data: (page) {
        if (page.results.isEmpty) {
          return _buildEmptyState(recentAsync);
        }
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: page.results.length + (page.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= page.results.length) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.gold,
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
      error: (_, _) => const SizedBox.shrink(),
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
                    color: AppColors.gold,
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
