import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/route_utils.dart';

class MultiRoutePageOne extends StatefulWidget {
  final bool isCupertino;
  const MultiRoutePageOne({super.key, required this.isCupertino});

  @override
  State<MultiRoutePageOne> createState() => _MultiRoutePageOneState();
}

class _MultiRoutePageOneState extends State<MultiRoutePageOne> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_result != null)
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 16),
          widget.isCupertino
              ? CupertinoButton.filled(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) =>
                            MultiRoutePageTwo(isCupertino: widget.isCupertino),
                      ),
                    );
                    if (result != null) {
                      setState(() => _result = result as String);
                    }
                  },
                  child: const Text('Start Flow (Go to Page 2)'),
                )
              : ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MultiRoutePageTwo(isCupertino: widget.isCupertino),
                      ),
                    );
                    if (result != null) {
                      setState(() => _result = result as String);
                    }
                  },
                  child: const Text('Start Flow (Go to Page 2)'),
                ),
        ],
      ),
    );

    return widget.isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Multi Route 1'),
            ),
            child: Material(type: MaterialType.transparency, child: body),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Multi Route 1')),
            body: body,
          );
  }
}

class MultiRoutePageTwo extends StatelessWidget {
  final bool isCupertino;
  const MultiRoutePageTwo({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCupertino
              ? CupertinoButton.filled(
                  onPressed: () => pushPage(
                    context,
                    isCupertino,
                    MultiRoutePageThree(isCupertino: isCupertino),
                  ),
                  child: const Text('Go to Page 3'),
                )
              : ElevatedButton(
                  onPressed: () => pushPage(
                    context,
                    isCupertino,
                    MultiRoutePageThree(isCupertino: isCupertino),
                  ),
                  child: const Text('Go to Page 3'),
                ),
          const SizedBox(height: 16),
          isCupertino
              ? CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Page 1'),
                )
              : TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Page 1'),
                ),
        ],
      ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Multi Route 2'),
            ),
            child: Material(type: MaterialType.transparency, child: body),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Multi Route 2')),
            body: body,
          );
  }
}

class MultiRoutePageThree extends StatelessWidget {
  final bool isCupertino;
  const MultiRoutePageThree({super.key, required this.isCupertino});

  @override
  Widget build(BuildContext context) {
    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isCupertino
              ? CupertinoButton.filled(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop('Success from Page 3!');
                  },
                  child: const Text('Pop to Page 1 with Data'),
                )
              : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop('Success from Page 3!');
                  },
                  child: const Text('Pop to Page 1 with Data'),
                ),
          const SizedBox(height: 16),
          isCupertino
              ? CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Pop 1 Page Back'),
                )
              : TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Pop 1 Page Back'),
                ),
        ],
      ),
    );

    return isCupertino
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Multi Route 3'),
            ),
            child: Material(type: MaterialType.transparency, child: body),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Multi Route 3')),
            body: body,
          );
  }
}
