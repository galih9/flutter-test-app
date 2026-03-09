import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';

class PhysicsSimulationPage extends StatefulWidget {
  final bool isCupertino;
  const PhysicsSimulationPage({super.key, required this.isCupertino});

  @override
  State<PhysicsSimulationPage> createState() => _PhysicsSimulationPageState();
}

class _PhysicsSimulationPageState extends State<PhysicsSimulationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dragValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this);
  }

  void _runSimulation(double velocity) {
    // Basic spring simulation returning to 0
    final simulation = SpringSimulation(
      const SpringDescription(mass: 1, stiffness: 100, damping: 10),
      _dragValue,
      0,
      velocity,
    );
    _controller.animateWith(simulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        _dragValue = _controller.value;
      });
    });

    final body = Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          _controller.stop();
          setState(() {
            _dragValue += details.delta.dy;
          });
        },
        onPanEnd: (details) {
          _runSimulation(details.velocity.pixelsPerSecond.dy);
        },
        child: Transform.translate(
          offset: Offset(0, _dragValue),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('Drag Me', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );

    return widget.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Physics Simulation'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Physics Simulation')),
            body: body,
          );
  }
}
