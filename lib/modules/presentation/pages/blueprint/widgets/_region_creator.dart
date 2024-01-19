part of '../blueprint_page.dart';

class _RegionCreator extends HookConsumerWidget {
  const _RegionCreator({
    required this.canvasWidth,
    required this.canvasHeight,
    required this.canvasKey,
    required this.onRegionChanged,
  });

  final double canvasWidth;
  final double canvasHeight;
  final GlobalKey canvasKey;
  final ValueChanged<Region> onRegionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragListener(
      onDragEnd: () {
        final region = ref.read(createRegionControllerProvider);
        ref.invalidate(createRegionControllerProvider);

        if (region != null) {
          onRegionChanged(region);
        }
      },
      onDragStart: (details) {
        final globalPosition = details.globalPosition;

        final canvasBox = canvasKey.renderBox!;
        final positionOnCanvas = canvasBox.globalToLocal(globalPosition);

        final notifier = ref.read(createRegionControllerProvider.notifier);
        notifier.onDragStart(
          positionOnCanvas: positionOnCanvas,
          canvasWidth: canvasWidth,
          canvasHeight: canvasHeight,
        );
      },
      onDragUpdate: (details) {
        final globalPosition = details.globalPosition;
        final canvasBox = canvasKey.renderBox!;
        final positionOnCanvas = canvasBox.globalToLocal(globalPosition);

        final notifier = ref.read(createRegionControllerProvider.notifier);
        notifier.onDragUpdate(
          positionOnCanvas: positionOnCanvas,
          canvasWidth: canvasWidth,
          canvasHeight: canvasHeight,
        );
      },
    );
  }
}
