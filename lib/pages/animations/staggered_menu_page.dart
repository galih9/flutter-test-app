import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaggeredMenuPage extends StatefulWidget {
  final bool isCupertino;
  const StaggeredMenuPage({super.key, required this.isCupertino});

  @override
  State<StaggeredMenuPage> createState() => _StaggeredMenuPageState();
}

class _StaggeredMenuPageState extends State<StaggeredMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> _menuItems = [
    'Home',
    'Profile',
    'Settings',
    'About',
    'Logout',
  ];
  final List<Animation<double>> _itemAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final double step = 0.5 / _menuItems.length;
    for (int i = 0; i < _menuItems.length; i++) {
      _itemAnimations.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.2 + (i * step),
              0.5 + (i * step),
              curve: Curves.easeOutBack,
            ),
          ),
        ),
      );
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isCupertino
                  ? CupertinoButton(
                      onPressed: () {
                        _controller.reset();
                        _controller.forward();
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.refresh),
                          SizedBox(width: 8),
                          Text('Replay'),
                        ],
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        _controller.reset();
                        _controller.forward();
                      },
                    ),
              const SizedBox(height: 24),
              ...List.generate(_menuItems.length, (index) {
                return Transform.translate(
                  offset: Offset(-200 * (1 - _itemAnimations[index].value), 0),
                  child: Opacity(
                    opacity: _itemAnimations[index].value.clamp(0.0, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        _menuItems[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );

    return widget.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Staggered Menu'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Staggered Menu')),
            body: body,
          );
  }
}
