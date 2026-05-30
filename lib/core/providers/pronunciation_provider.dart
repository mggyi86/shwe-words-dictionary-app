import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/core/services/pronunciation_service.dart';

final pronunciationServiceProvider = Provider<PronunciationService>((ref) {
  final service = PronunciationService();
  ref.onDispose(service.dispose);
  return service;
});

Future<void> pronounceWord(
  WidgetRef ref, {
  required String word,
  String? language,
  BuildContext? context,
}) async {
  try {
    await ref.read(pronunciationServiceProvider).speak(word, language: language);
  } on MissingPluginException {
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Stop the app and run it again (full rebuild). '
            'Hot reload cannot load pronunciation.',
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  } catch (e) {
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not play pronunciation: $e')),
      );
    }
  }
}
