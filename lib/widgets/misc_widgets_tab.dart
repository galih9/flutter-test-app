import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/route_utils.dart';
import '../pages/routing/simple_routing_page.dart';
import '../pages/routing/multi_routing_page.dart';
import '../pages/animations/implicit_animation_page.dart';
import '../pages/animations/hero_animation_page.dart';
import '../pages/animations/physics_simulation_page.dart';
import '../pages/animations/staggered_animation_page.dart';
import '../pages/animations/staggered_menu_page.dart';

class MiscWidgetsTab extends StatelessWidget {
  final bool isCupertino;
  const MiscWidgetsTab({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Images',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => Dialog(
                backgroundColor: Colors.transparent,
                child: InteractiveViewer(child: Image.asset('assets/dash.png')),
              ),
            );
          },
          child: isCupertino
              ? Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/dash.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/dash.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Cards / Surfaces',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (!isCupertino) ...[
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is a Default Card.'),
            ),
          ),
          const SizedBox(height: 8),
          const Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is an Elevated Card.'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            elevation: 0,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is a Filled Card.'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('This is an Outlined Card.'),
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ],
            ),
            child: const Text('This is an iOS styled surface Container.'),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemBackground.resolveFrom(
                context,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('This is a filled (flat) iOS Container.'),
          ),
        ],
        const SizedBox(height: 24),
        const Text(
          'Routing & Animations',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (!isCupertino) ...[
          ListTile(
            leading: const Icon(Icons.arrow_forward),
            title: const Text('Simple Route Navigation'),
            subtitle: const Text('Page 1 -> Page 2'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              SimpleRoutePageOne(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.layers),
            title: const Text('Multi-Page Routing'),
            subtitle: const Text('Navigate deeply and pop with result'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              MultiRoutePageOne(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('Hero Animation Showcase'),
            subtitle: const Text('Shared element transition'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              HeroAnimationPageOne(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check_box_outline_blank),
            title: const Text('Implicit Animations'),
            subtitle: const Text('Animated properties'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              AnimationShowcasePage(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.sports_basketball),
            title: const Text('Physics Simulation'),
            subtitle: const Text('Spring-based animations'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              PhysicsSimulationPage(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.blur_linear),
            title: const Text('Staggered Animation'),
            subtitle: const Text('Sequential animation steps'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              StaggeredAnimationPage(isCupertino: isCupertino),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Staggered Menu'),
            subtitle: const Text('Animated expanding menu'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => pushPage(
              context,
              isCupertino,
              StaggeredMenuPage(isCupertino: isCupertino),
            ),
          ),
        ] else ...[
          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.zero,
            children: [
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.arrow_right_circle),
                title: const Text('Simple Route Navigation'),
                subtitle: const Text('Page 1 -> Page 2'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  SimpleRoutePageOne(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.square_stack_3d_up),
                title: const Text('Multi-Page Routing'),
                subtitle: const Text('Navigate deeply and pop with result'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  MultiRoutePageOne(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.sparkles),
                title: const Text('Hero Animation Showcase'),
                subtitle: const Text('Shared element transition'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  HeroAnimationPageOne(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.play_circle),
                title: const Text('Implicit Animations'),
                subtitle: const Text('Animated properties'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  AnimationShowcasePage(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.sportscourt),
                title: const Text('Physics Simulation'),
                subtitle: const Text('Spring-based animations'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  PhysicsSimulationPage(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.bars),
                title: const Text('Staggered Animation'),
                subtitle: const Text('Sequential animation steps'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  StaggeredAnimationPage(isCupertino: isCupertino),
                ),
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.list_bullet),
                title: const Text('Staggered Menu'),
                subtitle: const Text('Animated expanding menu'),
                trailing: const CupertinoListTileChevron(),
                onTap: () => pushPage(
                  context,
                  isCupertino,
                  StaggeredMenuPage(isCupertino: isCupertino),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 24),
        const Text(
          'Lists & Dividers',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (!isCupertino) ...[
          const ListTile(
            leading: Icon(Icons.star),
            title: Text('ListTile Item 1'),
            subtitle: Text('This is a subtitle'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.favorite),
            title: Text('ListTile Item 2'),
            subtitle: Text('Another subtitle'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(thickness: 2, color: Colors.blue),
        ] else ...[
          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.zero,
            children: const [
              CupertinoListTile(
                leading: Icon(CupertinoIcons.star),
                title: Text('CupertinoListTile Item 1'),
                subtitle: Text('This is a subtitle'),
                trailing: CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                leading: Icon(CupertinoIcons.heart),
                title: Text('CupertinoListTile Item 2'),
                subtitle: Text('Another subtitle'),
                trailing: CupertinoListTileChevron(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
