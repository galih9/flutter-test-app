import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/pages/main_page.dart';
import 'package:test_app/pages/widgets_showcase_page.dart';
import 'package:test_app/pages/settings_page.dart';

void main() {
  testWidgets(
    'MainPage loads Showcase by default, switches to Settings on tap',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: MainPage())),
      );

      // Initial state: WidgetsShowcasePage should be visible
      expect(find.byType(WidgetsShowcasePage), findsOneWidget);

      // Tap on Settings tab
      await tester.tap(find.text('Settings').last);
      await tester.pumpAndSettle();

      // After tap state: SettingsPage should be visible
      expect(find.byType(SettingsPage), findsOneWidget);
    },
  );
}
