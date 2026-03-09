import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/route_utils.dart';

class SimpleRoutePageOne extends StatelessWidget {
  final bool isCupertino;
  const SimpleRoutePageOne({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: isCupertino
          ? CupertinoButton.filled(
              onPressed: () => pushPage(
                context,
                isCupertino,
                SimpleRoutePageTwo(isCupertino: isCupertino),
              ),
              child: const Text('Go to Page 2'),
            )
          : ElevatedButton(
              onPressed: () => pushPage(
                context,
                isCupertino,
                SimpleRoutePageTwo(isCupertino: isCupertino),
              ),
              child: const Text('Go to Page 2'),
            ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(middle: Text('Page 1')),
            child: Material(type: MaterialType.transparency, child: body),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Page 1')),
            body: body,
          );
  }
}

class SimpleRoutePageTwo extends StatelessWidget {
  final bool isCupertino;
  const SimpleRoutePageTwo({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: isCupertino
          ? CupertinoButton.filled(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            )
          : ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(middle: Text('Page 2')),
            child: Material(type: MaterialType.transparency, child: body),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Page 2')),
            body: body,
          );
  }
}
