import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shwewords/core/providers/pronunciation_provider.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/core/utils/meaning_display.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/features/search/providers/search_provider.dart';
import 'package:shwewords/features/word_detail/widgets/entry_detail_body.dart';

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
            icon: const Icon(Icons.volume_up_rounded),
            tooltip: 'Pronunciation',
            onPressed: () => pronounceWord(
              ref,
              word: entry.word,
              language: entry.language,
              context: context,
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? AppColors.gold : null,
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
      body: EntryDetailBody(entry: entry),
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
    final sections = MeaningDisplay.detailSectionsFromEntry(entry);

    for (final section in sections) {
      buffer.writeln(section.pos);
      for (final block in section.blocks) {
        for (final line in block.meanings) {
          if (line.kind == DetailLineKind.domain && line.domainLabel != null) {
            buffer.writeln('(${line.domainLabel}) ${line.text}');
          } else {
            buffer.writeln(line.text);
          }
        }
        for (final example in block.examples) {
          buffer.writeln('  "$example"');
        }
      }
      buffer.writeln();
    }

    if (entry.synonyms.isNotEmpty) {
      buffer.writeln('thesaurus');
      buffer.writeln('~ ${entry.synonyms.length} words related to ${entry.word}.');
      buffer.writeln(entry.synonyms.join(', '));
    }

    return buffer.toString().trim();
  }
}

final _entryProvider = FutureProvider.family<DictionaryEntry, int>((ref, id) async {
  final entry = await ref.watch(searchRepositoryProvider).getEntryById(id);
  if (entry == null) throw Exception('Entry not found');
  return entry;
});
