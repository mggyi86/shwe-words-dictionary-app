import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shwewords/core/providers/repository_providers.dart';
import 'package:shwewords/core/theme/app_colors.dart';
import 'package:shwewords/core/theme/app_theme.dart';
import 'package:shwewords/core/utils/meaning_display.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';

class EntryDetailBody extends StatelessWidget {
  const EntryDetailBody({super.key, required this.entry});

  final DictionaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final sections = MeaningDisplay.detailSectionsFromEntry(entry);
    final labelColor = AppColors.mutedText(brightness);
    final contentColor = AppColors.secondaryText(brightness);
    final primaryColor = AppColors.primaryText(brightness);
    final myanmarStyle = Theme.of(context).extension<MyanmarTypography>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Text(
          entry.word,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < sections.length; i++) ...[
          _PosSection(
            section: sections[i],
            accentColor: AppColors.detailSectionAccent(sections[i].pos, brightness),
            labelColor: labelColor,
            contentColor: contentColor,
            primaryColor: primaryColor,
            myanmarStyle: myanmarStyle,
            showTimelineBelow: entry.synonyms.isNotEmpty || i < sections.length - 1,
          ),
          if (i < sections.length - 1) const SizedBox(height: 28),
        ],
        if (entry.synonyms.isNotEmpty) ...[
          if (sections.isNotEmpty) const SizedBox(height: 28),
          _ThesaurusSection(
            word: entry.word,
            language: entry.language,
            synonyms: entry.synonyms,
            accentColor: AppColors.detailSectionAccent('thesaurus', brightness),
            labelColor: labelColor,
            contentColor: contentColor,
          ),
        ],
      ],
    );
  }
}

class _PosSection extends StatelessWidget {
  const _PosSection({
    required this.section,
    required this.accentColor,
    required this.labelColor,
    required this.contentColor,
    required this.primaryColor,
    required this.myanmarStyle,
    required this.showTimelineBelow,
  });

  final DetailSection section;
  final Color accentColor;
  final Color labelColor;
  final Color contentColor;
  final Color primaryColor;
  final MyanmarTypography? myanmarStyle;
  final bool showTimelineBelow;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineMarker(
            accentColor: accentColor,
            showLine: showTimelineBelow,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.pos,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: labelColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < section.blocks.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  _DetailBlockView(
                    block: section.blocks[i],
                    contentColor: contentColor,
                    primaryColor: primaryColor,
                    myanmarStyle: myanmarStyle,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineMarker extends StatelessWidget {
  const _TimelineMarker({
    required this.accentColor,
    required this.showLine,
  });

  final Color accentColor;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      child: Column(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accentColor, width: 1.5),
            ),
          ),
          if (showLine)
            Expanded(
              child: Container(
                width: 1.5,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: accentColor.withValues(alpha: 0.55),
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailBlockView extends StatelessWidget {
  const _DetailBlockView({
    required this.block,
    required this.contentColor,
    required this.primaryColor,
    required this.myanmarStyle,
  });

  final DetailBlock block;
  final Color contentColor;
  final Color primaryColor;
  final MyanmarTypography? myanmarStyle;

  @override
  Widget build(BuildContext context) {
    final conjugations = block.meanings
        .where((line) => line.kind == DetailLineKind.conjugation)
        .toList();
    final regularMeanings = block.meanings
        .where((line) => line.kind != DetailLineKind.conjugation)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in regularMeanings)
          _MeaningLine(
            line: line,
            contentColor: contentColor,
            primaryColor: primaryColor,
            myanmarStyle: myanmarStyle,
          ),
        for (final example in block.examples)
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 6, bottom: 4),
            child: SelectableText(
              example,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: contentColor.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                    height: 1.45,
                  ),
            ),
          ),
        if (conjugations.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: conjugations
                .map(
                  (line) => SelectableText(
                    line.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: contentColor.withValues(alpha: 0.75),
                          height: 1.4,
                        ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _MeaningLine extends StatelessWidget {
  const _MeaningLine({
    required this.line,
    required this.contentColor,
    required this.primaryColor,
    required this.myanmarStyle,
  });

  final DetailMeaningLine line;
  final Color contentColor;
  final Color primaryColor;
  final MyanmarTypography? myanmarStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: _LineMarker(kind: line.kind, contentColor: contentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _MeaningText(
              line: line,
              contentColor: contentColor,
              primaryColor: primaryColor,
              myanmarStyle: myanmarStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class _MeaningText extends StatelessWidget {
  const _MeaningText({
    required this.line,
    required this.contentColor,
    required this.primaryColor,
    required this.myanmarStyle,
  });

  final DetailMeaningLine line;
  final Color contentColor;
  final Color primaryColor;
  final MyanmarTypography? myanmarStyle;

  TextStyle _baseStyle(BuildContext context, {Color? color, FontWeight? weight}) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: color ?? contentColor,
          fontWeight: weight,
          height: 1.5,
        );
  }

  Color get _highlightColor => Color.lerp(contentColor, primaryColor, 0.82)!;

  TextStyle _applyMyanmarTypography(BuildContext context, String text, TextStyle base) {
    if (!MyanmarText.containsMyanmar(text)) return base;
    return myanmarStyle?.myanmar(context, base) ?? base;
  }

  @override
  Widget build(BuildContext context) {
    if (line.kind == DetailLineKind.domain) {
      return _DomainLine(
        label: line.domainLabel ?? '',
        text: line.text,
        contentColor: contentColor,
        primaryColor: primaryColor,
        myanmarStyle: myanmarStyle,
      );
    }

    if (line.kind == DetailLineKind.gloss) {
      final parsed = MeaningDisplay.parseMeaning(line.text);
      final englishStyle = _baseStyle(context, color: contentColor.withValues(alpha: 0.85));
      final myanmarBase = _baseStyle(
        context,
        color: _highlightColor,
        weight: FontWeight.w500,
      );
      final myanmarStyleResolved = _applyMyanmarTypography(
        context,
        parsed.myanmar ?? '',
        myanmarBase,
      );

      final spans = <InlineSpan>[];
      if (parsed.english != null && parsed.english!.isNotEmpty) {
        spans.add(TextSpan(text: '~ ${parsed.english}', style: englishStyle));
      } else if (line.text.startsWith('~')) {
        spans.add(TextSpan(text: line.text, style: englishStyle));
      }
      if (parsed.myanmar != null && parsed.myanmar!.isNotEmpty) {
        if (spans.isNotEmpty) {
          spans.add(TextSpan(text: ' ', style: englishStyle));
        }
        spans.add(TextSpan(text: parsed.myanmar, style: myanmarStyleResolved));
      }

      if (spans.isEmpty) {
        return SelectableText(line.text, style: englishStyle);
      }
      return SelectableText.rich(TextSpan(children: spans));
    }

    final isMyanmar = MyanmarText.containsMyanmar(line.text);
    final style = _applyMyanmarTypography(
      context,
      line.text,
      _baseStyle(
        context,
        color: isMyanmar ? _highlightColor : contentColor,
        weight: isMyanmar ? FontWeight.w500 : FontWeight.normal,
      ),
    );

    return SelectableText(line.text, style: style);
  }
}

class _LineMarker extends StatelessWidget {
  const _LineMarker({
    required this.kind,
    required this.contentColor,
  });

  final DetailLineKind kind;
  final Color contentColor;

  @override
  Widget build(BuildContext context) {
    final markerColor = contentColor.withValues(alpha: 0.75);

    return switch (kind) {
      DetailLineKind.gloss => Icon(
          Icons.home_outlined,
          size: 14,
          color: markerColor,
        ),
      DetailLineKind.domain => Icon(
          Icons.star_outline_rounded,
          size: 14,
          color: markerColor,
        ),
      DetailLineKind.conjugation => Text(
          '-',
          style: TextStyle(color: markerColor, fontSize: 15, height: 1.2),
        ),
      DetailLineKind.translation => Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: markerColor, width: 1.2),
          ),
        ),
    };
  }
}

class _DomainLine extends StatelessWidget {
  const _DomainLine({
    required this.label,
    required this.text,
    required this.contentColor,
    required this.primaryColor,
    required this.myanmarStyle,
  });

  final String label;
  final String text;
  final Color contentColor;
  final Color primaryColor;
  final MyanmarTypography? myanmarStyle;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.mutedText(Theme.of(context).brightness);
    final isMyanmar = MyanmarText.containsMyanmar(text);
    final highlightColor = Color.lerp(contentColor, primaryColor, 0.82)!;
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isMyanmar ? highlightColor : contentColor,
          fontWeight: isMyanmar ? FontWeight.w500 : FontWeight.normal,
          height: 1.5,
        );
    final resolvedStyle = isMyanmar
        ? myanmarStyle?.myanmar(context, textStyle!) ?? textStyle
        : textStyle;

    return SelectableText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '($label) ',
            style: textStyle?.copyWith(
              color: muted,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(text: text, style: resolvedStyle),
        ],
      ),
    );
  }
}

class _ThesaurusSection extends ConsumerStatefulWidget {
  const _ThesaurusSection({
    required this.word,
    required this.language,
    required this.synonyms,
    required this.accentColor,
    required this.labelColor,
    required this.contentColor,
  });

  final String word;
  final String language;
  final List<String> synonyms;
  final Color accentColor;
  final Color labelColor;
  final Color contentColor;

  @override
  ConsumerState<_ThesaurusSection> createState() => _ThesaurusSectionState();
}

class _ThesaurusSectionState extends ConsumerState<_ThesaurusSection> {
  Map<String, int>? _entryIds;

  @override
  void initState() {
    super.initState();
    _loadEntryIds();
  }

  Future<void> _loadEntryIds() async {
    final ids = await ref.read(searchRepositoryProvider).lookupEntryIds(
          widget.synonyms,
          language: widget.language,
        );
    if (mounted) {
      setState(() => _entryIds = ids);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: widget.contentColor,
          height: 1.5,
        );
    final linkStyle = baseStyle?.copyWith(
      color: AppColors.gold.withValues(alpha: 0.9),
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineMarker(accentColor: widget.accentColor, showLine: false),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'thesaurus',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: widget.labelColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  '~ ${widget.synonyms.length} words related to ${widget.word}.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.contentColor.withValues(alpha: 0.85),
                        height: 1.45,
                      ),
                ),
                const SizedBox(height: 12),
                if (_entryIds == null)
                  Text('…', style: baseStyle)
                else
                  _SynonymLinkText(
                    synonyms: widget.synonyms,
                    entryIds: _entryIds!,
                    baseStyle: baseStyle!,
                    linkStyle: linkStyle!,
                    onLinkTap: (id) => context.push('/word/$id'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SynonymLinkText extends StatefulWidget {
  const _SynonymLinkText({
    required this.synonyms,
    required this.entryIds,
    required this.baseStyle,
    required this.linkStyle,
    required this.onLinkTap,
  });

  final List<String> synonyms;
  final Map<String, int> entryIds;
  final TextStyle baseStyle;
  final TextStyle linkStyle;
  final ValueChanged<int> onLinkTap;

  @override
  State<_SynonymLinkText> createState() => _SynonymLinkTextState();
}

class _SynonymLinkTextState extends State<_SynonymLinkText> {
  final _recognizers = <TapGestureRecognizer>[];
  List<InlineSpan>? _spans;

  @override
  void initState() {
    super.initState();
    _rebuildSpans();
  }

  @override
  void didUpdateWidget(covariant _SynonymLinkText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.synonyms != widget.synonyms ||
        oldWidget.entryIds != widget.entryIds) {
      _rebuildSpans();
    }
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  void _rebuildSpans() {
    _disposeRecognizers();

    final spans = <InlineSpan>[];
    for (var i = 0; i < widget.synonyms.length; i++) {
      if (i > 0) {
        spans.add(TextSpan(text: '  ', style: widget.baseStyle));
      }

      final synonym = widget.synonyms[i];
      final entryId = widget.entryIds[synonym];
      if (entryId != null) {
        final recognizer = TapGestureRecognizer()
          ..onTap = () => widget.onLinkTap(entryId);
        _recognizers.add(recognizer);
        spans.add(
          TextSpan(
            text: synonym,
            style: widget.linkStyle,
            recognizer: recognizer,
          ),
        );
      } else {
        spans.add(TextSpan(text: synonym, style: widget.baseStyle));
      }
    }

    _spans = spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: _spans ?? const []));
  }
}
