import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loading_controller.g.dart';

@riverpod
class LoadingController extends _$LoadingController {
  final List<void> _loaders = [];

  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  void push() {
    _loaders.add(null);
    state = const AsyncLoading();
  }

  void pop() {
    _loaders.removeLast();
    if (_loaders.isEmpty) {
      state = const AsyncData(null);
    }
  }
}
