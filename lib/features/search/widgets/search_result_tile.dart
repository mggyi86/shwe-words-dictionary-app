import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shwewords/core/providers/pronunciation_provider.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_theme.dart';
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

  static const _gold = Color(0xFFD4AF37);
  static const _cardBackground = Color(0xFF1C1C20);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final entry = result.entry;
    final lines = MeaningDisplay.fromEntry(entry);
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();
    final hasEnglish =
        lines.englishLine != null && lines.englishLine!.isNotEmpty;
    final hasMyanmar =
        lines.myanmarLine != null && lines.myanmarLine!.isNotEmpty;
    final headwordColor = isDark ? _gold : Colors.black87;
    final posColor = isDark ? Colors.grey[400]! : Colors.black54;
    final englishDefinitionColor = isDark ? Colors.white : Colors.black87;
    final myanmarDefinitionColor = isDark ? Colors.grey[200]! : Colors.black87;
    final iconColor = isDark ? _gold : Colors.black54;

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
                color: isDark
                    ? _gold.withValues(alpha: 0.4)
                    : Colors.grey.shade300,
                width: 1.0,
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
                        style: TextStyle(
                          color: headwordColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (lines.pos != null) ...[
                        Text(
                          '~ ${lines.pos} ~',
                          style: TextStyle(
                            color: posColor,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        if (hasEnglish || hasMyanmar)
                          const SizedBox(height: 8),
                      ],
                      if (hasEnglish) ...[
                        Text(
                          lines.englishLine!,
                          style: TextStyle(
                            color: englishDefinitionColor,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        if (hasMyanmar) const SizedBox(height: 6),
                      ],
                      if (hasMyanmar)
                        Text.rich(
                          TextSpan(
                            children: [
                              if (lines.pos != null)
                                TextSpan(
                                  text: '${lines.pos} ',
                                  style: TextStyle(
                                    color: posColor,
                                    fontSize: 15,
                                  ),
                                ),
                              TextSpan(
                                text: lines.myanmarLine,
                                style: myanmarStyle?.myanmar(
                                      context,
                                      TextStyle(
                                        color: myanmarDefinitionColor,
                                        fontSize: 15,
                                        height: 1.4,
                                      ),
                                    ) ??
                                    TextStyle(
                                      color: myanmarDefinitionColor,
                                      fontSize: 15,
                                      height: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ActionIcon(
                      icon: isFavorite
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: iconColor,
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
                    _ActionIcon(
                      icon: Icons.volume_up_rounded,
                      color: iconColor,
                      tooltip: 'Pronunciation',
                      onPressed: () => pronounceWord(
                        ref,
                        word: entry.word,
                        language: entry.language,
                        context: context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ActionIcon(
                      icon: Icons.share_outlined,
                      color: iconColor,
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

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final Color color;
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
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            size: 22,
            color: color,
          ),
        ),
      ),
    );
  }
}
