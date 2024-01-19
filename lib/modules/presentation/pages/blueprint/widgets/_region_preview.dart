part of '../blueprint_page.dart';

class _RegionPreview extends HookConsumerWidget {
  const _RegionPreview({
    required this.region,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.canvasKey,
    this.isSelected = false,
    required this.onRegionChanged,
    required this.onRegionSelected,
  });

  final Region region;
  final bool isSelected;

  final double canvasWidth;
  final double canvasHeight;
  final GlobalKey canvasKey;
  final ValueChanged<Region> onRegionChanged;
  final ValueChanged<Region> onRegionSelected;

  int? divisionTouchedIndex({
    required Region region,
    required Offset positionOnRegion,
  }) {
    final regionWidth = region.relativeWidth * canvasWidth;
    final relativeX = positionOnRegion.dx / regionWidth;

    for (final division in region.divisions) {
      final divisionX = division.relativeToRegionX0;

      final isInsideLeft = relativeX >= divisionX - 0.02;
      final isInsideRight = relativeX <= divisionX + 0.02;

      if (isInsideLeft && isInsideRight) {
        return region.divisions.indexOf(division);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = useState(this.region);
    final startRegion = useState<Region?>(null);
    final startPosition = useState<Offset?>(null);
    final touchedPosition = useState<_TouchPosition?>(null);
    final touchedDivisionIndex = useState<int?>(null);

    final width = canvasWidth * region.value.relativeWidth;
    final height = canvasHeight * region.value.relativeHeight;

    final positionX = canvasWidth * region.value.relativeOriginX;
    final positionY = canvasHeight * region.value.relativeOriginY;

    useEffect(() {
      region.value = this.region;
      return () {};
    }, [this.region]);

    return Positioned(
      left: positionX,
      top: positionY,
      width: width,
      height: height,
      child: CustomPaint(
        size: Size(canvasWidth, canvasHeight),
        painter: _RegionPainter(
          isSelected: isSelected,
          canvasWidth: canvasWidth,
          canvasHeight: canvasHeight,
          region: region.value,
        ),
        child: DragListener(
          onDragEnd: () {
            startRegion.value = null;
            startPosition.value = null;
            touchedPosition.value = null;
            touchedDivisionIndex.value = null;
          },
          onDragStart: (details) {
            final globalPosition = details.globalPosition;

            final canvasBox = canvasKey.renderBox!;
            final positionOnCanvas = canvasBox.globalToLocal(globalPosition);

            startPosition.value = positionOnCanvas;
            startRegion.value = region.value;

            final index = divisionTouchedIndex(
              region: region.value,
              positionOnRegion: details.localPosition,
            );

            if (index != null) {
              touchedDivisionIndex.value = index;
            } else {
              touchedPosition.value = _TouchPosition.fromOffset(
                details.localPosition,
                width,
                height,
              );
            }

            onRegionSelected(region.value);
          },
          onDragUpdate: (details) {
            final globalPosition = details.globalPosition;
            final localPosition = details.localPosition;

            final canvasBox = canvasKey.renderBox!;
            final positionOnCanvas = canvasBox.globalToLocal(globalPosition);

            if (touchedDivisionIndex.value != null) {
              final regionWidth = region.value.relativeWidth * canvasWidth;

              final newRegion = region.value.resizeDivision(
                index: touchedDivisionIndex.value!,
                regionWidth: regionWidth,
                positionOnRegion: localPosition,
              );

              region.value = newRegion;
              onRegionChanged(newRegion);

              return;
            }

            switch (touchedPosition.value) {
              case _TouchPosition.topLeft:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  leftRelative: positionOnCanvas.dx / canvasWidth,
                  topRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.topRight:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  rightRelative: positionOnCanvas.dx / canvasWidth,
                  topRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.bottomLeft:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  leftRelative: positionOnCanvas.dx / canvasWidth,
                  bottomRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.bottomRight:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  rightRelative: positionOnCanvas.dx / canvasWidth,
                  bottomRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.top:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  topRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.bottom:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  bottomRelative: positionOnCanvas.dy / canvasHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.left:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  leftRelative: positionOnCanvas.dx / canvasWidth,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.right:
                final newRegion = region.value.resize(
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                  rightRelative: positionOnCanvas.dx / canvasWidth,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              case _TouchPosition.center:
                final newRegion = region.value.move(
                  canvasWidth: canvasWidth,
                  canvasHeight: canvasHeight,
                  startPositionOnCanvas: startPosition.value!,
                  positionOnCanvas: positionOnCanvas,
                  startOriginRelativeX: startRegion.value!.relativeOriginX,
                  startOriginRelativeY: startRegion.value!.relativeOriginY,
                  startRelativeWidth: startRegion.value!.relativeWidth,
                  startRelativeHeight: startRegion.value!.relativeHeight,
                );

                region.value = newRegion;
                onRegionChanged(newRegion);
              default:
            }
          },
        ),
      ),
    );
  }
}

enum _TouchPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  top,
  bottom,
  left,
  right,
  center;

  bool get isTopLeft => this == _TouchPosition.topLeft;
  bool get isTopRight => this == _TouchPosition.topRight;
  bool get isBottomLeft => this == _TouchPosition.bottomLeft;
  bool get isBottomRight => this == _TouchPosition.bottomRight;
  bool get isTop => this == _TouchPosition.top;
  bool get isBottom => this == _TouchPosition.bottom;
  bool get isLeft => this == _TouchPosition.left;
  bool get isRight => this == _TouchPosition.right;
  bool get isCenter => this == _TouchPosition.center;

  static _TouchPosition fromOffset(
    Offset offset,
    double width,
    double height,
  ) {
    final x = offset.dx;
    final y = offset.dy;

    final isTop = y < height * 0.1;
    final isBottom = y > height * 0.9;
    final isLeft = x < width * 0.1;
    final isRight = x > width * 0.9;

    if (isTop && isLeft) {
      return _TouchPosition.topLeft;
    } else if (isTop && isRight) {
      return _TouchPosition.topRight;
    } else if (isBottom && isLeft) {
      return _TouchPosition.bottomLeft;
    } else if (isBottom && isRight) {
      return _TouchPosition.bottomRight;
    } else if (isTop) {
      return _TouchPosition.top;
    } else if (isBottom) {
      return _TouchPosition.bottom;
    } else if (isLeft) {
      return _TouchPosition.left;
    } else if (isRight) {
      return _TouchPosition.right;
    } else {
      return _TouchPosition.center;
    }
  }
}
