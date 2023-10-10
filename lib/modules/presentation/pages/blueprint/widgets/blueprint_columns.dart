import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../application/blueprint_controller.dart';
import 'blueprint_column_item.dart';

class BlueprintColumns extends StatelessWidget {
  const BlueprintColumns({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              'Columns to extract',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: Obx(() {
              final controller = Get.find<BlueprintController>();
              final rectangles = controller.highlightRects;
              if (rectangles.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Add a column by dragging the area on the PDF',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                itemCount: rectangles.length,
                itemBuilder: (context, index) {
                  return ColumnItem(
                    index: index,
                  );
                },
              );
            }),
          ),
          const _ClearButton(),
        ],
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintController>();
      final rectangles = controller.highlightRects;
      if (rectangles.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        height: 56,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: controller.clearRects,
          child: const Text('Clear all'),
        ),
      );
    });
  }
}
