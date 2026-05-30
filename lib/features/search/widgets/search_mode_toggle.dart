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

  static const _outerRadius = 12.0;
  static const _darkContainerBackground = Color(0xFF1C1C20);
  static const _darkSelectedBackground = Color(0xFF2A3A2A);
  static const _lightSelectedBackground = Color(0xFFE2EFE2);
  static const _lightSelectedForeground = Color(0xFF1A431A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? _darkContainerBackground : Colors.white,
        borderRadius: BorderRadius.circular(_outerRadius),
        border: Border.all(
          color: isDark
              ? AppColors.gold.withValues(alpha: 0.3)
              : Colors.grey.shade300,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_outerRadius),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              _Segment(
                label: 'English',
                icon: mode == SearchMode.english
                    ? Icons.check_rounded
                    : Icons.abc_rounded,
                selected: mode == SearchMode.english,
                onTap: () => onChanged(SearchMode.english),
                segmentIndex: 0,
                segmentCount: 3,
                isDark: isDark,
              ),
              _Segment(
                label: 'Myanmar',
                icon: Icons.translate_rounded,
                selected: mode == SearchMode.myanmar,
                onTap: () => onChanged(SearchMode.myanmar),
                segmentIndex: 1,
                segmentCount: 3,
                isDark: isDark,
              ),
              _Segment(
                label: 'Synonym',
                icon: Icons.swap_horiz_rounded,
                selected: mode == SearchMode.synonym,
                onTap: () => onChanged(SearchMode.synonym),
                segmentIndex: 2,
                segmentCount: 3,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.segmentIndex,
    required this.segmentCount,
    required this.isDark,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final int segmentIndex;
  final int segmentCount;
  final bool isDark;

  BorderRadius? _selectedBorderRadius() {
    if (!selected) return null;

    if (segmentIndex == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(SearchModeToggle._outerRadius),
        bottomLeft: Radius.circular(SearchModeToggle._outerRadius),
      );
    }
    if (segmentIndex == segmentCount - 1) {
      return const BorderRadius.only(
        topRight: Radius.circular(SearchModeToggle._outerRadius),
        bottomRight: Radius.circular(SearchModeToggle._outerRadius),
      );
    }
    return BorderRadius.zero;
  }

  Color _selectedBackground() {
    if (isDark) return SearchModeToggle._darkSelectedBackground;
    return SearchModeToggle._lightSelectedBackground;
  }

  Color _foregroundColor() {
    if (selected) {
      return isDark
          ? Colors.green[400]!
          : SearchModeToggle._lightSelectedForeground;
    }
    return isDark ? Colors.grey[400]! : Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = _selectedBorderRadius();
    final background = selected ? _selectedBackground() : Colors.transparent;
    final foreground = _foregroundColor();

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 40,
            decoration: BoxDecoration(
              color: background,
              borderRadius: borderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w400,
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
