import 'package:flutter_test/flutter_test.dart';
import 'package:shwewords/core/utils/meaning_display.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';

void main() {
  group('MeaningDisplay', () {
    test('splits gloss with Myanmar script', () {
      final parsed = MeaningDisplay.parseMeaning('~ addition ထပ်ပေါင်းခြင်း');

      expect(parsed.english, 'addition');
      expect(parsed.myanmar, 'ထပ်ပေါင်းခြင်း');
    });

    test('returns latin-only meaning as english', () {
      final parsed = MeaningDisplay.parseMeaning(
        'the action of adding; an addition or increase',
      );

      expect(parsed.english, 'the action of adding; an addition or increase');
      expect(parsed.myanmar, isNull);
    });

    test('returns myanmar-only meaning as myanmar', () {
      final parsed = MeaningDisplay.parseMeaning('ထပ်ပေါင်းသည်');

      expect(parsed.english, isNull);
      expect(parsed.myanmar, 'ထပ်ပေါင်းသည်');
    });

    test('fromEntry uses first definition and example fallback', () {
      const entry = DictionaryEntry(
        word: 'add',
        language: 'en',
        definitions: [
          Definition(
            pos: 'noun',
            meanings: ['~ addition ထပ်ပေါင်းခြင်း'],
            examples: ['If you add 5 and 5 together you get 10.'],
          ),
        ],
      );

      final lines = MeaningDisplay.fromEntry(entry);

      expect(lines.pos, 'noun');
      expect(lines.englishLine, 'addition');
      expect(lines.myanmarLine, 'ထပ်ပေါင်းခြင်း');
    });

    test('fromEntry falls back to example when no english gloss', () {
      const entry = DictionaryEntry(
        word: 'paddle',
        language: 'en',
        definitions: [
          Definition(
            pos: 'noun',
            meanings: ['တက်'],
            examples: ["Let's go for a paddle."],
          ),
        ],
      );

      final lines = MeaningDisplay.fromEntry(entry);

      expect(lines.pos, 'noun');
      expect(lines.englishLine, "Let's go for a paddle.");
      expect(lines.myanmarLine, 'တက်');
    });
  });
}
