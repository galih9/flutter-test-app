import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logger/logger.dart';
import 'package:test_app/main.dart' as app;

var logger = Logger();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the tabs', (tester) async {
      app.main();
      logger.i('start waiting');
      // This moves the clock forward by 2 seconds regardless of animations
      await tester.pump(const Duration(seconds: 2));
      logger.i('wait complete');
      final miscTab = find.text('Misc');
      await tester.ensureVisible(miscTab);
      await tester.pump(const Duration(milliseconds: 500));

      expect(miscTab, findsOneWidget);
      await tester.tap(miscTab);
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text("Routing & Animations"), findsOneWidget);
    });
    testWidgets('tap on the Settings tab, verify settings are displayed', (
      tester,
    ) async {
      app.main();
      logger.i('start waiting');
      // This moves the clock forward by 2 seconds regardless of animations
      await tester.pump(const Duration(seconds: 2));
      logger.i('wait complete');
      // Verify that Showcase tab is shown initially
      expect(find.text('Widgets Showcase'), findsOneWidget);

      // Tap on the settings tab
      final settingsTab = find.byTooltip('Settings');
      await tester.tap(settingsTab);

      // Trigger a frame
      await tester.pump(const Duration(seconds: 1));

      // Verify we are on settings page. (We check for App Theme)
      expect(find.text('App Theme'), findsOneWidget);
    });
  });
}
