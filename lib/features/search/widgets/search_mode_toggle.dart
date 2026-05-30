import 'package:flutter/material.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/domain/entities/search_result.dart';

class SearchModeToggle extends StatelessWidget {
  const SearchModeToggle({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final SearchMode mode;
  final ValueChanged<SearchMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final borderColor = AppColors.goldBorder(brightness);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          _Segment(
            label: 'English',
            icon: mode == SearchMode.english
                ? Icons.check_rounded
                : Icons.abc_rounded,
            selected: mode == SearchMode.english,
            onTap: () => onChanged(SearchMode.english),
            activeStyle: _englishActiveStyle(brightness),
          ),
          _Segment(
            label: 'Myanmar',
            icon: Icons.translate_rounded,
            selected: mode == SearchMode.myanmar,
            onTap: () => onChanged(SearchMode.myanmar),
          ),
          _Segment(
            label: 'Synonym',
            icon: Icons.swap_horiz_rounded,
            selected: mode == SearchMode.synonym,
            onTap: () => onChanged(SearchMode.synonym),
            glowWhenSelected: true,
          ),
        ],
      ),
    );
  }

  _SegmentActiveStyle _englishActiveStyle(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const _SegmentActiveStyle(
        background: AppColors.englishTabActiveDark,
        foreground: AppColors.englishTabActiveTextDark,
      );
    }
    return const _SegmentActiveStyle(
      background: AppColors.englishTabActive,
      foreground: AppColors.englishTabActiveText,
    );
  }
}

class _SegmentActiveStyle {
  const _SegmentActiveStyle({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.activeStyle,
    this.glowWhenSelected = false,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final _SegmentActiveStyle? activeStyle;
  final bool glowWhenSelected;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final gold = AppColors.goldBorder(brightness);

    Color background = Colors.transparent;
    Color foreground = AppColors.mutedText(brightness);
    List<BoxShadow> shadows = const [];

    if (selected && activeStyle != null) {
      background = activeStyle!.background;
      foreground = activeStyle!.foreground;
    } else if (selected && glowWhenSelected) {
      background =
          isDark ? AppColors.synonymTabActiveDark : AppColors.lightSearchFill;
      foreground = gold;
      shadows = AppColors.tabGlow(brightness);
    } else if (selected) {
      background = AppColors.searchFill(brightness);
      foreground = AppColors.primaryText(brightness);
    }

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(9),
              border: selected && glowWhenSelected
                  ? Border.all(color: gold, width: 1)
                  : null,
              boxShadow: shadows,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 13,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
