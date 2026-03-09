import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final refreshCountProvider = NotifierProvider<RefreshCountNotifier, int>(
  RefreshCountNotifier.new,
);

class RefreshCountNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}

final apiFetchProvider = FutureProvider<String>((ref) async {
  final refreshCount = ref.watch(refreshCountProvider);
  await Future.delayed(const Duration(seconds: 2));
  return 'Data successfully fetched from API! (Refresh $refreshCount)';
});

typedef StreamDataState = ({List<int> items, bool isDone, bool isWaiting});

final streamDataProvider = StreamProvider<StreamDataState>((ref) async* {
  ref.watch(refreshCountProvider);

  final List<int> accumulated = [];
  yield (items: const [], isDone: false, isWaiting: true);

  for (int i = 1; i <= 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    accumulated.add(i);
    yield (items: List.from(accumulated), isDone: false, isWaiting: false);
  }

  yield (items: accumulated, isDone: true, isWaiting: false);
});

class StreamWidgetsTab extends ConsumerWidget {
  final bool isCupertino;
  const StreamWidgetsTab({super.key, required this.isCupertino});

  Future<void> _handleRefresh(WidgetRef ref) async {
    ref.read(refreshCountProvider.notifier).increment();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final futureState = ref.watch(apiFetchProvider);
    final streamState = ref.watch(streamDataProvider);
    final streamData =
        streamState.value ?? (items: const [], isDone: false, isWaiting: true);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'FutureProvider',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (isCupertino)
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _handleRefresh(ref),
                child: const Icon(CupertinoIcons.refresh),
              )
            else
              IconButton(
                onPressed: () => _handleRefresh(ref),
                icon: const Icon(Icons.refresh),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCupertino
                ? CupertinoColors.systemBackground.resolveFrom(context)
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: futureState.when(
            data: (data) => Row(
              children: [
                Icon(
                  isCupertino
                      ? CupertinoIcons.check_mark_circled
                      : Icons.check_circle,
                  color: isCupertino
                      ? CupertinoColors.activeGreen
                      : Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(data)),
              ],
            ),
            error: (err, stack) => Text('Error: $err'),
            loading: () => Column(
              children: [
                isCupertino
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text('Fetching data...'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'StreamProvider (List View)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCupertino
                ? CupertinoColors.systemBackground.resolveFrom(context)
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              if (streamData.isWaiting)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Waiting for initial stream events...'),
                ),
              ...streamData.items.map(
                (data) => isCupertino
                    ? CupertinoListTile(
                        leading: const Icon(
                          CupertinoIcons.bolt_horizontal_circle_fill,
                        ),
                        title: const Text('Stream Event Received'),
                        subtitle: Text('Payload ID: $data'),
                      )
                    : ListTile(
                        leading: const Icon(Icons.flash_on),
                        title: const Text('Stream Event Received'),
                        subtitle: Text('Payload ID: $data'),
                      ),
              ),
              if (!streamData.isWaiting)
                if (!streamData.isDone)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Listening for more events...'),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Stream successfully closed.'),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isCupertino) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () => _handleRefresh(ref)),
          SliverToBoxAdapter(child: _buildContent(context, ref)),
        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: () => _handleRefresh(ref),
        child: _buildContent(context, ref),
      );
    }
  }
}
