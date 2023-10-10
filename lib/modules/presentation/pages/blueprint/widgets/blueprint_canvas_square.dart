import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../application/blueprint_controller.dart';
import '../../../../domain/highlight_rect.dart';

class BlueprintCanvasSquare extends StatefulWidget {
  const BlueprintCanvasSquare({
    super.key,
    required this.rect,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.canvasKey,
    this.isSelected = false,
  });

  final HighlightRect rect;
  final double canvasWidth;
  final double canvasHeight;
  final GlobalKey canvasKey;
  final bool isSelected;

  @override
  State<BlueprintCanvasSquare> createState() => _BlueprintCanvasSquareState();
}

class _BlueprintCanvasSquareState extends State<BlueprintCanvasSquare> {
  bool isSizingTop = false;
  bool isSizingBottom = false;
  bool isSizingLeft = false;
  bool isSizingRight = false;
  bool isMoving = false;

  void resizeRect({
    double? relativeX1,
    double? relativeY1,
    double? relativeX2,
    double? relativeY2,
  }) {
    final controller = Get.find<BlueprintController>();
    final index = controller.selectedIndex.value;
    if (index == null) return;

    controller.highlightRects[index] = widget.rect.transformSize(
      relativeX1: relativeX1,
      relativeY1: relativeY1,
      relativeX2: relativeX2,
      relativeY2: relativeY2,
    );
  }

  void moveRect({
    required Offset localPointerOffset,
  }) {
    final controller = Get.find<BlueprintController>();
    final index = controller.selectedIndex.value;
    if (index == null) return;

    double? relativeX = localPointerOffset.dx / widget.canvasWidth;
    double? relativeY = localPointerOffset.dy / widget.canvasHeight;

    controller.highlightRects[index] = widget.rect.transformPosition(
      offsetX: relativeX,
      offsetY: relativeY,
    );
  }

  void onDragUpdate(DragUpdateDetails details) {
    final canvasBox =
        widget.canvasKey.currentContext!.findRenderObject() as RenderBox;
    final canvasOffset = canvasBox.globalToLocal(details.globalPosition);

    if (isMoving) {
      moveRect(localPointerOffset: canvasOffset);
      return;
    }

    double? relativeX1;
    double? relativeY1;
    double? relativeX2;
    double? relativeY2;

    if (isSizingRight) {
      relativeX2 = canvasOffset.dx / widget.canvasWidth;
    }

    if (isSizingLeft) {
      relativeX1 = canvasOffset.dx / widget.canvasWidth;
    }

    if (isSizingTop) {
      relativeY1 = canvasOffset.dy / widget.canvasHeight;
    }

    if (isSizingBottom) {
      relativeY2 = canvasOffset.dy / widget.canvasHeight;
    }

    resizeRect(
      relativeX1: relativeX1,
      relativeY1: relativeY1,
      relativeX2: relativeX2,
      relativeY2: relativeY2,
    );
  }

  void onInteractionStart(dynamic details) {
    FocusScope.of(context).unfocus();

    final width = widget.canvasWidth * widget.rect.width;
    final height = widget.canvasHeight * widget.rect.height;

    final x = details.localPosition.dx / width;
    final y = details.localPosition.dy / height;

    if (x < 0.1) {
      isSizingLeft = true;
    } else if (x > 0.9) {
      isSizingRight = true;
    } else if (y < 0.1) {
      isSizingTop = true;
    } else if (y > 0.9) {
      isSizingBottom = true;
    } else {
      isMoving = true;
    }

    if (x < 0.1 && y < 0.1) {
      isSizingTop = true;
      isSizingLeft = true;
    } else if (x > 0.9 && y < 0.1) {
      isSizingTop = true;
      isSizingRight = true;
    } else if (x < 0.1 && y > 0.9) {
      isSizingBottom = true;
      isSizingLeft = true;
    } else if (x > 0.9 && y > 0.9) {
      isSizingBottom = true;
      isSizingRight = true;
    } else if (x < 0.1) {
      isSizingLeft = true;
    } else if (x > 0.9) {
      isSizingRight = true;
    } else if (y < 0.1) {
      isSizingTop = true;
    } else if (y > 0.9) {
      isSizingBottom = true;
    } else {
      isMoving = true;
    }

    Get.find<BlueprintController>().onSelectRect(widget.rect);
  }

  void onInteractionEnd(dynamic _) {
    isMoving = false;
    isSizingLeft = false;
    isSizingRight = false;
    isSizingTop = false;
    isSizingBottom = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.canvasWidth * widget.rect.width;
    final height = widget.canvasHeight * widget.rect.height;

    final positionX = widget.canvasWidth * widget.rect.originX;
    final positionY = widget.canvasHeight * widget.rect.originY;

    var borderWidth = (widget.canvasWidth * 0.002).clamp(0, 2);
    var borderColor = Theme.of(context).primaryColor;

    if (widget.isSelected) {
      borderWidth = (widget.canvasWidth * 0.004).clamp(0, 4);
      borderColor = Colors.red;
    }

    return Positioned(
      left: positionX,
      top: positionY,
      width: width,
      height: height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: onDragUpdate,
        onHorizontalDragUpdate: onDragUpdate,
        onVerticalDragEnd: onInteractionEnd,
        onHorizontalDragEnd: onInteractionEnd,
        onVerticalDragStart: onInteractionStart,
        onHorizontalDragStart: onInteractionStart,
        onTapDown: onInteractionStart,
        onVerticalDragCancel: () => onInteractionEnd(null),
        onHorizontalDragCancel: () => onInteractionEnd(null),
        onTap: () {},
        onTapCancel: () {},
        onTapUp: (TapUpDetails details) {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: borderWidth.toDouble(),
            ),
          ),
        ),
      ),
    );
  }
}
