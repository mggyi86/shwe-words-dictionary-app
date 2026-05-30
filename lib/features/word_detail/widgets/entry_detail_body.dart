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
    final sections = MeaningDisplay.detailSectionsFromEntry(entry);
    final posColor = AppColors.mutedText(Theme.of(context).brightness);
    final contentColor = AppColors.secondaryText(Theme.of(context).brightness);
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
            posColor: posColor,
            contentColor: contentColor,
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
            posColor: posColor,
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
    required this.posColor,
    required this.contentColor,
    required this.myanmarStyle,
    required this.showTimelineBelow,
  });

  final DetailSection section;
  final Color posColor;
  final Color contentColor;
  final MyanmarTypography? myanmarStyle;
  final bool showTimelineBelow;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineMarker(
            posColor: posColor,
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
                        color: posColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < section.blocks.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  _DetailBlockView(
                    block: section.blocks[i],
                    contentColor: contentColor,
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
    required this.posColor,
    required this.showLine,
  });

  final Color posColor;
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
              border: Border.all(color: posColor, width: 1.2),
            ),
          ),
          if (showLine)
            Expanded(
              child: Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: posColor.withValues(alpha: 0.35),
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
    required this.myanmarStyle,
  });

  final DetailBlock block;
  final Color contentColor;
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
            myanmarStyle: myanmarStyle,
          ),
        for (final example in block.examples)
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 6, bottom: 4),
            child: SelectableText(
              example,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: contentColor.withValues(alpha: 0.85),
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
    required this.myanmarStyle,
  });

  final DetailMeaningLine line;
  final Color contentColor;
  final MyanmarTypography? myanmarStyle;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: contentColor,
          height: 1.5,
        );

    final textStyle = MyanmarText.containsMyanmar(line.text)
        ? myanmarStyle?.myanmar(context, baseStyle!) ?? baseStyle
        : baseStyle;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: _LineMarker(kind: line.kind),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: line.kind == DetailLineKind.domain
                ? _DomainLine(
                    label: line.domainLabel ?? '',
                    text: line.text,
                    textStyle: textStyle,
                  )
                : SelectableText(
                    line.text,
                    style: textStyle,
                  ),
          ),
        ],
      ),
    );
  }
}

class _LineMarker extends StatelessWidget {
  const _LineMarker({required this.kind});

  final DetailLineKind kind;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.mutedText(Theme.of(context).brightness);

    return switch (kind) {
      DetailLineKind.gloss => Icon(
          Icons.home_outlined,
          size: 14,
          color: color,
        ),
      DetailLineKind.domain => Icon(
          Icons.star_outline_rounded,
          size: 14,
          color: color,
        ),
      DetailLineKind.conjugation => Text(
          '-',
          style: TextStyle(color: color, fontSize: 15, height: 1.2),
        ),
      DetailLineKind.translation => Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.8),
          ),
        ),
    };
  }
}

class _DomainLine extends StatelessWidget {
  const _DomainLine({
    required this.label,
    required this.text,
    required this.textStyle,
  });

  final String label;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final muted = AppColors.mutedText(Theme.of(context).brightness);

    return SelectableText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '($label) ',
            style: textStyle?.copyWith(
              color: muted,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(text: text, style: textStyle),
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
    required this.posColor,
    required this.contentColor,
  });

  final String word;
  final String language;
  final List<String> synonyms;
  final Color posColor;
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
      color: AppColors.gold,
      decoration: TextDecoration.none,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TimelineMarker(posColor: widget.posColor, showLine: false),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'thesaurus',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: widget.posColor,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  '~ ${widget.synonyms.length} words related to ${widget.word}.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.contentColor.withValues(alpha: 0.9),
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
