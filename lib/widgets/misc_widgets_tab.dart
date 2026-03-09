import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
