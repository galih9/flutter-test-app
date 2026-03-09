import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../providers/design_language_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final designLanguage = ref.watch(designLanguageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Preferences',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('App Theme'),
            subtitle: const Text('Change the app mode (Light/Dark)'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  ref.read(themeProvider.notifier).setTheme(newMode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone_iphone),
            title: const Text('Design Language'),
            subtitle: const Text('Material vs Cupertino'),
            trailing: SegmentedButton<DesignLanguage>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: DesignLanguage.material,
                  label: Text('Material'),
                ),
                ButtonSegment(
                  value: DesignLanguage.cupertino,
                  label: Text('Cupertino'),
                ),
              ],
              selected: {designLanguage},
              onSelectionChanged: (Set<DesignLanguage> newSelection) {
                ref
                    .read(designLanguageProvider.notifier)
                    .setLanguage(newSelection.first);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('App Information'),
            subtitle: Text(
              'Showcase App using Riverpod for State Management and showing various widgets.',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.verified),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
