import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DragListener extends HookWidget {
  const DragListener({
    super.key,
    required this.onDragUpdate,
    required this.onDragStart,
    required this.onDragEnd,
    this.child,
    this.behavior = HitTestBehavior.opaque,
  });

  final ValueChanged<DragChangeDetails> onDragUpdate;
  final ValueChanged<DragChangeDetails> onDragStart;
  final VoidCallback onDragEnd;
  final Widget? child;
  final HitTestBehavior behavior;

  @override
  Widget build(BuildContext context) {
    final lastPosition = useState<Offset?>(null);

    return GestureDetector(
      behavior: behavior,
      onVerticalDragStart: (details) {
        lastPosition.value = details.globalPosition;
        onDragStart(DragChangeDetails(
          localPosition: details.localPosition,
          globalPosition: details.globalPosition,
          delta: Offset.zero,
        ));
      },
      onHorizontalDragStart: (details) {
        lastPosition.value = details.globalPosition;
        onDragStart(DragChangeDetails(
          localPosition: details.localPosition,
          globalPosition: details.globalPosition,
          delta: Offset.zero,
        ));
      },
      // onTapDown: (details) {
      //   lastPosition.value = details.globalPosition;
      //   onDragStart(DragChangeDetails(
      //     localPosition: details.localPosition,
      //     globalPosition: details.globalPosition,
      //     delta: Offset.zero,
      //   ));
      // },
      onVerticalDragUpdate: (details) {
        lastPosition.value = details.globalPosition;
        onDragUpdate(DragChangeDetails(
          localPosition: details.localPosition,
          globalPosition: details.globalPosition,
          delta: details.delta,
        ));
      },
      onHorizontalDragUpdate: (details) {
        lastPosition.value = details.globalPosition;
        onDragUpdate(DragChangeDetails(
          localPosition: details.localPosition,
          globalPosition: details.globalPosition,
          delta: details.delta,
        ));
      },
      onVerticalDragEnd: (_) {
        lastPosition.value = null;
        onDragEnd();
      },
      onHorizontalDragEnd: (_) {
        lastPosition.value = null;
        onDragEnd();
      },
      onVerticalDragCancel: () {
        lastPosition.value = null;
        onDragEnd();
      },
      onHorizontalDragCancel: () {
        lastPosition.value = null;
        onDragEnd();
      },
      child: child,
    );
  }
}

class DragChangeDetails {
  const DragChangeDetails({
    required this.localPosition,
    required this.globalPosition,
    required this.delta,
  });

  final Offset localPosition;
  final Offset globalPosition;
  final Offset delta;
}
