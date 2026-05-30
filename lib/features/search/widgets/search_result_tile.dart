import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shwewords/core/providers/pronunciation_provider.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final entry = result.entry;
    final preview = entry.cardPreviewLine;
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();
    final gold = AppColors.goldBorder(brightness);

    final isFavAsync = ref.watch(
      favoriteStatusProvider((word: entry.word, language: entry.language)),
    );
    final isFavorite = isFavAsync.valueOrNull ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: AppColors.cardGlow(brightness),
        ),
        child: Material(
          color: AppColors.cardBackground(brightness),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: gold, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          result.word,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: AppColors.primaryText(brightness),
                                    height: 1.2,
                                  ),
                        ),
                      ),
                      _GoldIconButton(
                        icon: isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                        filled: isFavorite,
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
                      _GoldIconButton(
                        icon: Icons.volume_up_rounded,
                        tooltip: 'Pronunciation',
                        onPressed: () => pronounceWord(
                          ref,
                          word: entry.word,
                          language: entry.language,
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  if (preview.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            preview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: _previewStyle(
                              context,
                              brightness,
                              myanmarStyle,
                              preview,
                            ),
                          ),
                        ),
                        _GoldIconButton(
                          icon: Icons.share_outlined,
                          tooltip: 'Share',
                          onPressed: () => Share.share(
                            _formatEntryText(entry),
                            subject: entry.word,
                          ),
                        ),
                      ],
                    ),
                  ] else
                    Align(
                      alignment: Alignment.centerRight,
                      child: _GoldIconButton(
                        icon: Icons.share_outlined,
                        tooltip: 'Share',
                        onPressed: () => Share.share(
                          _formatEntryText(entry),
                          subject: entry.word,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle? _previewStyle(
    BuildContext context,
    Brightness brightness,
    MyanmarTypography? myanmarStyle,
    String preview,
  ) {
    final base = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.mutedText(brightness),
          fontSize: 14,
          height: 1.35,
        );
    if (base == null) return null;
    if (MyanmarText.containsMyanmar(preview)) {
      return myanmarStyle?.myanmar(context, base) ?? base;
    }
    return base;
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

class _GoldIconButton extends StatelessWidget {
  const _GoldIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final gold = AppColors.goldBorder(Theme.of(context).brightness);

    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      icon: Icon(
        icon,
        size: 20,
        color: filled ? gold : gold.withValues(alpha: 0.85),
      ),
    );
  }
}
