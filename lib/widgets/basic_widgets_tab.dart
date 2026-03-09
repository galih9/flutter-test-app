import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BasicWidgetsTab extends StatefulWidget {
  final bool isCupertino;
  const BasicWidgetsTab({super.key, required this.isCupertino});

  @override
  State<BasicWidgetsTab> createState() => _BasicWidgetsTabState();
}

class _BasicWidgetsTabState extends State<BasicWidgetsTab> {
  String _segmentedVal = 'Day';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Buttons',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (!widget.isCupertino) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              FilledButton(onPressed: () {}, child: const Text('Filled')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
              TextButton(onPressed: () {}, child: const Text('Text')),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Icon Buttons:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Button Group / Segmented:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Day', label: Text('Day')),
              ButtonSegment(value: 'Week', label: Text('Week')),
              ButtonSegment(value: 'Month', label: Text('Month')),
            ],
            selected: {_segmentedVal},
            onSelectionChanged: (val) =>
                setState(() => _segmentedVal = val.first),
          ),
          const SizedBox(height: 16),
          const Text(
            'Floating Action Button:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.small(
                onPressed: () {},
                heroTag: 'fab1',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: () {},
                heroTag: 'fab2',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 8),
              FloatingActionButton.extended(
                onPressed: () {},
                heroTag: 'fab3',
                icon: const Icon(Icons.add),
                label: const Text('Create'),
              ),
            ],
          ),
        ] else ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {},
                child: const Text('Filled'),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: CupertinoColors.systemGrey5,
                onPressed: () {},
                child: const Text(
                  'Tonal',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {},
                child: const Text('Text'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Icon Buttons:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(CupertinoIcons.heart),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(8),
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(30),
                onPressed: () {},
                child: const Icon(
                  CupertinoIcons.heart_fill,
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Segmented Control:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<String>(
              children: const {
                'Day': Text('Day'),
                'Week': Text('Week'),
                'Month': Text('Month'),
              },
              groupValue: _segmentedVal,
              onValueChanged: (val) {
                if (val != null) setState(() => _segmentedVal = val);
              },
            ),
          ),
        ],
        const SizedBox(height: 32),
        const Text(
          'Indicators',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (!widget.isCupertino) ...[
          const Text(
            'Loading (Circular):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularProgressIndicator(),
              CircularProgressIndicator(strokeWidth: 8.0), // Thick variant
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Progress (Linear):',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(value: 0.7),
          const SizedBox(height: 16),
          const LinearProgressIndicator(
            value: 0.4,
            minHeight: 12,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ), // Thick, rounded variant
          ),
        ] else ...[
          const Text(
            'Activity Indicators:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoActivityIndicator(),
              CupertinoActivityIndicator(radius: 20), // Large variant
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Progress Bar:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Center(child: Text('(Cupertino has no native progress bar)')),
        ],
      ],
    );
  }
}
