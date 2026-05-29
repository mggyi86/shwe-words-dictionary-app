import 'package:flutter_test/flutter_test.dart';
import 'package:shwewords/core/utils/fts_query_sanitizer.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';

void main() {
  group('FtsQuerySanitizer', () {
    test('prefixQuery builds word prefix match', () {
      expect(
        FtsQuerySanitizer.prefixQuery('word', 'water'),
        'word:water*',
      );
    });

    test('prefixQuery returns empty for blank input', () {
      expect(FtsQuerySanitizer.prefixQuery('word', '   '), '');
    });

    test('prefixQuery strips FTS special characters', () {
      expect(
        FtsQuerySanitizer.prefixQuery('word', 'wa"ter'),
        'word:wa* AND word:ter*',
      );
    });

    test('trigramQuery builds Myanmar partial match', () {
      expect(
        FtsQuerySanitizer.trigramQuery('meanings_my', 'ရေ'),
        'meanings_my:ရေ',
      );
    });

    test('exactPhrase wraps query in quotes', () {
      expect(
        FtsQuerySanitizer.exactPhrase('word', 'hello'),
        'word:"hello"',
      );
    });
  });

  group('MyanmarText', () {
    test('containsMyanmar detects Myanmar script', () {
      expect(MyanmarText.containsMyanmar('ရေ'), isTrue);
      expect(MyanmarText.containsMyanmar('water'), isFalse);
    });

    test('normalize trims and collapses whitespace', () {
      expect(MyanmarText.normalize('  hello   world  '), 'hello world');
    });
  });
}
