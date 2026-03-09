import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/providers/theme_provider.dart';

void main() {
  test('ThemeNotifier default state is ThemeMode.system', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final mode = container.read(themeProvider);
    expect(mode, ThemeMode.system);
  });

  test('ThemeNotifier setTheme updates state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(themeProvider.notifier).setTheme(ThemeMode.dark);

    final mode = container.read(themeProvider);
    expect(mode, ThemeMode.dark);
  });
}
