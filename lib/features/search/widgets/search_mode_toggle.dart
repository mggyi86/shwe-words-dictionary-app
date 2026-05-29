import 'package:flutter/material.dart';
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
    return SegmentedButton<SearchMode>(
      segments: const [
        ButtonSegment(
          value: SearchMode.english,
          label: Text('English'),
          icon: Icon(Icons.abc, size: 18),
        ),
        ButtonSegment(
          value: SearchMode.myanmar,
          label: Text('Myanmar'),
          icon: Icon(Icons.translate, size: 18),
        ),
        ButtonSegment(
          value: SearchMode.synonym,
          label: Text('Synonym'),
          icon: Icon(Icons.sync_alt, size: 18),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}
