import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/features/search/providers/search_provider.dart';

class WordDetailScreen extends ConsumerWidget {
  const WordDetailScreen({super.key, required this.entryId});

  final int entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryAsync = ref.watch(_entryProvider(entryId));

    return entryAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Word')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Word')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (entry) => _WordDetailContent(entry: entry),
    );
  }
}

class _WordDetailContent extends ConsumerWidget {
  const _WordDetailContent({required this.entry});

  final DictionaryEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavAsync = ref.watch(
      favoriteStatusProvider((word: entry.word, language: entry.language)),
    );
    final isFavorite = isFavAsync.valueOrNull ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.word),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : null,
            ),
            tooltip: 'Favorite',
            onPressed: () async {
              await ref.read(favoritesRepositoryProvider).toggleFavorite(entry);
              ref.invalidate(
                favoriteStatusProvider(
                  (word: entry.word, language: entry.language),
                ),
              );
              ref.invalidate(favoritesProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            tooltip: 'Copy',
            onPressed: () => _copyEntry(context, entry),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share',
            onPressed: () => _shareEntry(entry),
          ),
        ],
      ),
      body: _EntryBody(entry: entry),
    );
  }

  void _copyEntry(BuildContext context, DictionaryEntry entry) {
    final text = _formatEntryText(entry);
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _shareEntry(DictionaryEntry entry) {
    Share.share(_formatEntryText(entry), subject: entry.word);
  }

  String _formatEntryText(DictionaryEntry entry) {
    final buffer = StringBuffer('${entry.word}\n\n');
    for (final def in entry.definitions) {
      if (def.pos != null) buffer.writeln('[${def.pos}]');
      for (final m in def.meanings) {
        buffer.writeln('• $m');
      }
      for (final ex in def.examples) {
        buffer.writeln('  "$ex"');
      }
      buffer.writeln();
    }
    if (entry.synonyms.isNotEmpty) {
      buffer.writeln('Synonyms: ${entry.synonyms.join(', ')}');
    }
    return buffer.toString();
  }
}

final _entryProvider = FutureProvider.family<DictionaryEntry, int>((ref, id) async {
  final entry = await ref.watch(searchRepositoryProvider).getEntryById(id);
  if (entry == null) throw Exception('Entry not found');
  return entry;
});

class _EntryBody extends StatelessWidget {
  const _EntryBody({required this.entry});

  final DictionaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          entry.word,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          entry.language.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 24),
        ...entry.definitions.map((def) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (def.pos != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      def.pos!,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                const SizedBox(height: 8),
                ...def.meanings.map(
                  (m) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: SelectableText(
                      m,
                      style: myanmarStyle?.myanmar(
                            context,
                            Theme.of(context).textTheme.titleLarge!,
                          ) ??
                          Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                ...def.examples.map(
                  (ex) => Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: SelectableText(
                      '"$ex"',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        if (entry.synonyms.isNotEmpty) ...[
          Text('Synonyms', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: entry.synonyms.map((s) => Chip(label: Text(s))).toList(),
          ),
        ],
      ],
    );
  }
}
