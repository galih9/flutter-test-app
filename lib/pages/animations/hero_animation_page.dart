import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/route_utils.dart';

class HeroAnimationPageOne extends StatelessWidget {
  final bool isCupertino;
  const HeroAnimationPageOne({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: GestureDetector(
        onTap: () => pushPage(
          context,
          isCupertino,
          HeroAnimationPageTwo(isCupertino: isCupertino),
        ),
        child: Hero(
          tag: 'hero-dash',
          child: Image.asset('assets/dash.png', width: 100, height: 100),
        ),
      ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Hero Animation 1'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Hero Animation 1')),
            body: body,
          );
  }
}

class HeroAnimationPageTwo extends StatelessWidget {
  final bool isCupertino;
  const HeroAnimationPageTwo({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Hero(
              tag: 'hero-dash',
              child: Image.asset(
                'assets/dash.png',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
              'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '
              'officia deserunt mollit anim id est laborum.\n\n'
              'Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. '
              'Nullam varius, turpis et commodo pharetra, est eros bibendum elit, '
              'nec luctus magna felis sollicitudin mauris. Integer in mauris eu '
              'nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. '
              'Donec lobortis risus a elit. Etiam tempor. Ut ullamcorper, ligula '
              'eu tempor congue, eros est euismod turpis, id tincidunt sapien '
              'risus a quam. Maecenas fermentum consequat mi.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Hero Animation 2'),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: SafeArea(child: body),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Hero Animation 2')),
            body: body,
          );
  }
}
