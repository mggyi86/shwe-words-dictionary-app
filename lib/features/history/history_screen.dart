import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/router/app_router.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/features/search/providers/search_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History & Favorites'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Recent'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _RecentTab(),
            _FavoritesTab(),
          ],
        ),
      ),
    );
  }
}

class _RecentTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAsync = ref.watch(recentSearchesProvider);

    return recentAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (recent) {
        if (recent.isEmpty) {
          return const Center(child: Text('No recent searches'));
        }

        return Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await ref
                      .read(favoritesRepositoryProvider)
                      .clearRecentSearches();
                  ref.invalidate(recentSearchesProvider);
                },
                child: const Text('Clear all'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recent.length,
                itemBuilder: (context, index) {
                  final term = recent[index];
                  return ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(term),
                    onTap: () {
                      ref.read(searchQueryProvider.notifier).state = term;
                      ref
                          .read(searchControllerProvider.notifier)
                          .search(query: term);
                      context.go(AppRoutes.home);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FavoritesTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favAsync = ref.watch(favoritesProvider);
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();

    return favAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (favorites) {
        if (favorites.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final entry = favorites[index];
            return ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: Text(entry.word),
              subtitle: Text(
                entry.primaryMeaning,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: myanmarStyle?.myanmar(
                      context,
                      Theme.of(context).textTheme.bodySmall!,
                    ),
              ),
              onTap: () async {
                final result = await ref
                    .read(searchRepositoryProvider)
                    .exactLookup(entry.word, language: entry.language);
                if (result != null && context.mounted) {
                  // Navigate via search - user can find word on home
                  ref.read(searchQueryProvider.notifier).state = entry.word;
                  ref
                      .read(searchControllerProvider.notifier)
                      .search(query: entry.word);
                  context.go(AppRoutes.home);
                }
              },
            );
          },
        );
      },
    );
  }
}
