import 'package:flutter/material.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/search_result.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.result,
    required this.onTap,
  });

  final SearchResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final myanmar = result.entry.primaryMeaning;
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.word,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (myanmar.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  myanmar,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: myanmarStyle?.myanmar(
                        context,
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ) ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
