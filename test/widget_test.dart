import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shwewords/core/config/app_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final tempDir = await Directory.systemTemp.createTemp('shwewords_widget_');
    Hive.init(tempDir.path);
  });

  test('AppConfig has expected branding', () {
    expect(
      AppConfig.appName,
      'English Myanmar Dictionary - ShweWords',
    );
    expect(AppConfig.appShortName, 'ShweWords');
  });

  test('ProviderScope can be instantiated', () {
    const scope = ProviderScope(
      child: SizedBox.shrink(),
    );
    expect(scope, isNotNull);
  });
}
