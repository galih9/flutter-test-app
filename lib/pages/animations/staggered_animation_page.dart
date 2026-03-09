import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaggeredAnimationPage extends StatefulWidget {
  final bool isCupertino;
  const StaggeredAnimationPage({super.key, required this.isCupertino});

  @override
  State<StaggeredAnimationPage> createState() => _StaggeredAnimationPageState();
}

class _StaggeredAnimationPageState extends State<StaggeredAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _width;
  late Animation<double> _height;
  late Animation<Color?> _color;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _width = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.ease),
      ),
    );

    _height = Tween<double>(begin: 50, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.ease),
      ),
    );

    _color = ColorTween(begin: Colors.blue, end: Colors.red).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.ease),
      ),
    );

    _opacity = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.ease),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacity.value,
                child: Container(
                  width: _width.value,
                  height: _height.value,
                  color: _color.value,
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          widget.isCupertino
              ? CupertinoButton.filled(
                  onPressed: () {
                    if (_controller.status == AnimationStatus.completed) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  child: const Text('Play Animation'),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (_controller.status == AnimationStatus.completed) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  child: const Text('Play Animation'),
                ),
        ],
      ),
    );

    return widget.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Staggered Animation'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Staggered Animation')),
            body: body,
          );
  }
}
