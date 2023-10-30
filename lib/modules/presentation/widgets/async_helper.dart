import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/async_value.dart';

class AsyncHelper extends StatefulWidget {
  const AsyncHelper({
    super.key,
    required this.child,
    this.loadingObservers = const [],
    this.errorObservers = const [],
  });

  final Widget child;
  final List<Rx<AsyncValue>> loadingObservers;
  final List<Rx<AsyncValue>> errorObservers;

  @override
  State<AsyncHelper> createState() => _AsyncHelperState();
}

class _AsyncHelperState extends State<AsyncHelper> {
  late final Worker _everAllError;

  @override
  void initState() {
    super.initState();

    _everAllError = everAll(widget.errorObservers, (value) {
      final value_ = value as AsyncValue;
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
    return Stack(
      children: [
        widget.child,
        if (widget.loadingObservers.isNotEmpty)
          Obx(() {
            final isLoading = widget.loadingObservers.any((element) {
              return element.value.isLoading;
            });

            if (isLoading) {
              return Positioned.fill(
                child: WillPopScope(
                  onWillPop: () async => false,
                  child: const ColoredBox(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          }),
      ],
    );
  }
}
