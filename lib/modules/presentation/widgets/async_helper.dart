import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utils/async_value.dart' as app;

class AsyncHelper extends ConsumerStatefulWidget {
  const AsyncHelper({
    super.key,
    required this.child,
    this.loadingObservers = const [],
    this.errorObservers = const [],
    this.loadingProviders = const [],
  });

  final Widget child;
  final List<Rx<app.AsyncValue>> loadingObservers;
  final List<Rx<app.AsyncValue>> errorObservers;

  final List<ProviderListenable<AsyncValue>> loadingProviders;

  @override
  ConsumerState<AsyncHelper> createState() => _AsyncHelperState();
}

class _AsyncHelperState extends ConsumerState<AsyncHelper> {
  late final Worker _everAllError;

  @override
  void initState() {
    super.initState();

    _everAllError = everAll(widget.errorObservers, (value) {
      final value_ = value as app.AsyncValue;
      if (value_.hasError) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(value_.asError.message.toString()),
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _everAllError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (final observer in widget.loadingObservers) {
      if (!observer.value.isLoading) continue;

      return Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: WillPopScope(
              onWillPop: () async => false,
              child: const ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      );
    }

    for (final provider in widget.loadingProviders) {
      final value = ref.watch(provider);
      if (!value.isLoading) continue;

      return Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: WillPopScope(
              onWillPop: () async => false,
              child: const ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return widget.child;
  }
}
