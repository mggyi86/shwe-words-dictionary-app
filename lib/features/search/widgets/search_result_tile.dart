import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shwewords/core/providers/pronunciation_provider.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/core/utils/fts_query_sanitizer.dart';
import 'package:shwewords/core/utils/meaning_display.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/search_result.dart';
import 'package:shwewords/features/search/providers/search_provider.dart';

class SearchResultTile extends ConsumerWidget {
  const SearchResultTile({
    super.key,
    required this.result,
    required this.onTap,
  });

  final SearchResult result;
  final VoidCallback onTap;

  static const _cardBackground = Color(0xFF1C1C20);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final entry = result.entry;
    final searchMode = ref.watch(searchModeProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final isSynonymMode = searchMode == SearchMode.synonym;
    final matchedSynonyms = isSynonymMode
        ? FtsQuerySanitizer.matchingSynonyms(entry.synonyms, searchQuery)
        : const <String>[];
    final sections = MeaningDisplay.cardSectionsFromEntry(entry);
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();
    final posColor = isDark ? Colors.grey[400]! : Colors.black54;
    final definitionColor = isDark ? Colors.grey[200]! : Colors.black87;

    final isFavAsync = ref.watch(
      favoriteStatusProvider((word: entry.word, language: entry.language)),
    );
    final isFavorite = isFavAsync.valueOrNull ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? _cardBackground : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        result.word,
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (isSynonymMode) ...[
                        Text(
                          'thesaurus',
                          style: TextStyle(
                            color: posColor,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          matchedSynonyms.isNotEmpty
                              ? matchedSynonyms.join(', ')
                              : entry.synonyms.take(8).join(', '),
                          style: TextStyle(
                            color: definitionColor,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ] else
                        for (var i = 0; i < sections.length; i++) ...[
                          if (i > 0) const SizedBox(height: 10),
                          Text(
                            sections[i].pos,
                            style: TextStyle(
                              color: posColor,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          for (final line in sections[i].lines)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                line,
                                style: myanmarStyle?.myanmar(
                                      context,
                                      TextStyle(
                                        color: definitionColor,
                                        fontSize: 15,
                                        height: 1.4,
                                      ),
                                    ) ??
                                    TextStyle(
                                      color: definitionColor,
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                              ),
                            ),
                        ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CardActionIcon(
                      icon: isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: 24,
                      tooltip: 'Favorite',
                      onPressed: () async {
                        await ref
                            .read(favoritesRepositoryProvider)
                            .toggleFavorite(entry);
                        ref.invalidate(
                          favoriteStatusProvider(
                            (word: entry.word, language: entry.language),
                          ),
                        );
                        ref.invalidate(favoritesProvider);
                      },
                    ),
                    const SizedBox(height: 24),
                    _CardActionIcon(
                      icon: Icons.volume_up_rounded,
                      size: 24,
                      tooltip: 'Pronunciation',
                      onPressed: () => pronounceWord(
                        ref,
                        word: entry.word,
                        language: entry.language,
                        context: context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _CardActionIcon(
                      icon: Icons.share_outlined,
                      size: 22,
                      tooltip: 'Share',
                      onPressed: () => Share.share(
                        _formatEntryText(entry),
                        subject: entry.word,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatEntryText(DictionaryEntry entry) {
    final buffer = StringBuffer('${entry.word}\n\n');
    for (final def in entry.definitions) {
      if (def.pos != null) buffer.writeln('[${def.pos}]');
      for (final m in def.meanings) {
        buffer.writeln('• $m');
      }
      buffer.writeln();
    }
    return buffer.toString().trim();
  }
}

class _CardActionIcon extends StatelessWidget {
  const _CardActionIcon({
    required this.icon,
    required this.size,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Icon(
          icon,
          color: const Color(0xFFD4AF37),
          size: size,
        ),
      ),
    );
  }
}
