import 'blueprint_canvas_square.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../application/blueprint_controller.dart';
import '../../../../domain/highlight_rect.dart';

class BlueprintCanvas extends StatefulWidget {
  const BlueprintCanvas({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<BlueprintCanvas> createState() => _BlueprintCanvasState();
}

class _BlueprintCanvasState extends State<BlueprintCanvas> {
  final canvasKey = GlobalKey();

  bool isCreatingRect = false;

  void createRect({
    required relativeX1,
    required relativeY1,
  }) {
    final rect = HighlightRect(
      relativeX1: relativeX1,
      relativeY1: relativeY1,
      relativeX2: relativeX1,
      relativeY2: relativeY1,
    );

    final controller = Get.find<BlueprintController>();
    controller.addRect(rect);
    controller.selectedIndex.value = controller.highlightRects.length - 1;
  }

  void resizeRect({
    double? relativeX2,
    double? relativeY2,
  }) {
    final controller = Get.find<BlueprintController>();
    final index = controller.selectedIndex.value;
    if (index == null) return;

    final rect = controller.highlightRects[index];
    controller.highlightRects[index] = rect.transformSize(
      relativeX2: relativeX2,
      relativeY2: relativeY2,
    );
  }

  void onInteractionEnd(dynamic _) {
    isCreatingRect = false;
  }

  void onDragUpdate(BuildContext context, DragUpdateDetails details) {
    FocusScope.of(context).unfocus();

    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    final mousePointerX = localOffset.dx / box.size.width;
    final mousePointerY = localOffset.dy / box.size.height;

    final controller = Get.find<BlueprintController>();
    final index = controller.selectedIndex.value;

    if (index == null || !isCreatingRect) {
      isCreatingRect = true;
      createRect(
        relativeX1: mousePointerX,
        relativeY1: mousePointerY,
      );
    } else {
      resizeRect(
        relativeX2: mousePointerX,
        relativeY2: mousePointerY,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintController>();

      return GestureDetector(
        onVerticalDragUpdate: (details) => onDragUpdate(context, details),
        onHorizontalDragUpdate: (details) => onDragUpdate(context, details),
        onVerticalDragEnd: onInteractionEnd,
        onHorizontalDragEnd: onInteractionEnd,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.transparent,
          key: canvasKey,
          child: Stack(
            fit: StackFit.expand,
            children: controller.highlightRects.mapIndexed((index, rect) {
              return BlueprintCanvasSquare(
                rect: rect,
                canvasWidth: widget.width,
                canvasHeight: widget.height,
                canvasKey: canvasKey,
                isSelected: controller.selectedIndex.value == index,
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
