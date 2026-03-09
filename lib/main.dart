import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/main_page.dart';
import 'providers/theme_provider.dart';
import 'providers/design_language_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final designLanguage = ref.watch(designLanguageProvider);
    final targetPlatform = designLanguage == DesignLanguage.cupertino
        ? TargetPlatform.iOS
        : TargetPlatform.android;

    return MaterialApp(
      key: ValueKey(designLanguage),
      title: 'Widgets Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        platform: targetPlatform,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(platform: targetPlatform),
      themeMode: themeMode,
      home: const MainPage(),
    );
  }
}
