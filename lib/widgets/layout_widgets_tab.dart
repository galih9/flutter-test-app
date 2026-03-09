import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LayoutWidgetsTab extends StatelessWidget {
  final bool isCupertino;
  const LayoutWidgetsTab({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Row & Column Layout:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Container(
            color: isCupertino
                ? CupertinoColors.systemGrey5
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Wrap Layout:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List.generate(
              12,
              (index) => Chip(
                label: Text('Chip $index'),
                avatar: CircleAvatar(child: Text('$index')),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Stack & Positioned Layout:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue.shade100,
                  width: double.infinity,
                  height: 150,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    color: Colors.red.shade300,
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Top L',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    color: Colors.green.shade300,
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Bot R',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
          if (!isCupertino) ...[
            const SizedBox(height: 24),
            const Text(
              'Navigation Drawer (Mock):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              height: 400, // Drawer needs more height
              width: double.infinity,
              alignment: Alignment.centerLeft, // Align drawer to left
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  children: [
                    NavigationDrawer(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                          child: Text(
                            'Mail',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        NavigationDrawerDestination(
                          icon: Icon(Icons.inbox),
                          label: Text('Inbox'),
                        ),
                        NavigationDrawerDestination(
                          icon: Icon(Icons.send),
                          label: Text('Outbox'),
                        ),
                      ],
                    ),
                    const Expanded(child: Center(child: Text('Content Area'))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Navigation Rail (Mock):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.bookmark_border),
                          selectedIcon: Icon(Icons.book),
                          label: Text('Saved'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    const Expanded(child: Center(child: Text('Content Area'))),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
