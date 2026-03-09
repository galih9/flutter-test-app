import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AnimationShowcasePage extends StatefulWidget {
  final bool isCupertino;
  const AnimationShowcasePage({super.key, required this.isCupertino});

  @override
  State<AnimationShowcasePage> createState() => _AnimationShowcasePageState();
}

class _AnimationShowcasePageState extends State<AnimationShowcasePage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final body = ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Implicit Animation (AnimatedContainer)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _isExpanded ? 200 : 100,
              height: _isExpanded ? 200 : 100,
              decoration: BoxDecoration(
                color: _isExpanded ? Colors.indigo : Colors.deepPurple,
                borderRadius: BorderRadius.circular(_isExpanded ? 100 : 16),
              ),
              child: const Center(
                child: Text(
                  'Tap Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return widget.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Animations'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Animations')),
            body: body,
          );
  }
}
