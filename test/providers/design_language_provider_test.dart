import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/providers/design_language_provider.dart';

void main() {
  test('DesignLanguageNotifier default state is material', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final lang = container.read(designLanguageProvider);
    expect(lang, DesignLanguage.material);
  });

  test('DesignLanguageNotifier setLanguage updates state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(designLanguageProvider.notifier)
        .setLanguage(DesignLanguage.cupertino);

    final lang = container.read(designLanguageProvider);
    expect(lang, DesignLanguage.cupertino);
  });
}
