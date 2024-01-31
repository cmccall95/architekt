import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/region.dart';

part 'create_region_controller.g.dart';

@riverpod
class CreateRegionController extends _$CreateRegionController {
  Region? _startRegion;
  Offset? _startPosition;

  @override
  Region? build() {
    return null;
  }

  void onDragStart({
    required Offset positionOnCanvas,
    required double canvasWidth,
    required double canvasHeight,
  }) {
    _startPosition = positionOnCanvas;
    _startRegion = Region(
      relativeX0: positionOnCanvas.dx / canvasWidth,
      relativeY0: positionOnCanvas.dy / canvasHeight,
      relativeX1: positionOnCanvas.dx / canvasWidth,
      relativeY1: positionOnCanvas.dy / canvasHeight,
    );

    state = _startRegion;
  }

  void onDragUpdate({
    required Offset positionOnCanvas,
    required double canvasWidth,
    required double canvasHeight,
  }) {
    var region = state;
    region ??= Region(
      relativeX0: positionOnCanvas.dx / canvasWidth,
      relativeY0: positionOnCanvas.dy / canvasHeight,
      relativeX1: positionOnCanvas.dx / canvasWidth,
      relativeY1: positionOnCanvas.dy / canvasHeight,
    );

    var startRegion = _startRegion;
    startRegion ??= region;

    var startPosition = _startPosition;
    startPosition ??= positionOnCanvas;

    state = region.resize(
      bottomRelative: positionOnCanvas.dy / canvasHeight,
      rightRelative: positionOnCanvas.dx / canvasWidth,
      startOriginRelativeX: startRegion.relativeOriginX,
      startOriginRelativeY: startRegion.relativeOriginY,
      startRelativeWidth: startRegion.relativeWidth,
      startRelativeHeight: startRegion.relativeHeight,
    );
  }
}
