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
