import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/design_language_provider.dart';
import '../widgets/basic_widgets_tab.dart';
import '../widgets/input_widgets_tab.dart';
import '../widgets/dialogs_tab.dart';
import '../widgets/layout_widgets_tab.dart';
import '../widgets/misc_widgets_tab.dart';
import '../widgets/stream_widgets_tab.dart';

class WidgetsShowcasePage extends ConsumerStatefulWidget {
  const WidgetsShowcasePage({super.key});

  @override
  ConsumerState<WidgetsShowcasePage> createState() =>
      _WidgetsShowcasePageState();
}

class _WidgetsShowcasePageState extends ConsumerState<WidgetsShowcasePage> {
  int _selectedTab = 0;

  final _tabs = ['Basic', 'Inputs', 'Dialogs', 'Layout', 'Misc', 'Stream'];

  Widget _buildMaterialPage() {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Widgets Showcase'),
          bottom: TabBar(
            isScrollable: true,
            tabs: _tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
          children: const [
            BasicWidgetsTab(isCupertino: false),
            InputWidgetsTab(isCupertino: false),
            DialogsTab(isCupertino: false),
            LayoutWidgetsTab(isCupertino: false),
            MiscWidgetsTab(isCupertino: false),
            StreamWidgetsTab(isCupertino: false),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl<int>(
          children: const {
            0: Text('Basic', style: TextStyle(fontSize: 13)),
            1: Text('Inputs', style: TextStyle(fontSize: 13)),
            2: Text('Dialogs', style: TextStyle(fontSize: 13)),
            3: Text('Layout', style: TextStyle(fontSize: 13)),
            4: Text('Misc', style: TextStyle(fontSize: 13)),
            5: Text('Stream', style: TextStyle(fontSize: 13)),
          },
          groupValue: _selectedTab,
          onValueChanged: (val) {
            if (val != null) setState(() => _selectedTab = val);
          },
        ),
      ),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: IndexedStack(
            index: _selectedTab,
            children: const [
              BasicWidgetsTab(isCupertino: true),
              InputWidgetsTab(isCupertino: true),
              DialogsTab(isCupertino: true),
              LayoutWidgetsTab(isCupertino: true),
              MiscWidgetsTab(isCupertino: true),
              StreamWidgetsTab(isCupertino: true),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCupertino =
        ref.watch(designLanguageProvider) == DesignLanguage.cupertino;
    return isCupertino ? _buildCupertinoPage() : _buildMaterialPage();
  }
}
