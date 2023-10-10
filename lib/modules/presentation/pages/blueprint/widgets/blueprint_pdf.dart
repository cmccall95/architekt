import 'package:arkitekt/modules/presentation/pages/blueprint/widgets/blueprint_columns.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../application/blueprint_pdf_controller.dart';
import 'blueprint_canvas.dart';

class BlueprintPdf extends StatelessWidget {
  const BlueprintPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        BlueprintColumns(),
        VerticalDivider(width: 0),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _PreviousButton(),
                SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: _Blueprint(),
                  ),
                ),
                SizedBox(width: 10),
                _NextButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Blueprint extends StatelessWidget {
  const _Blueprint({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintPdfController>();
      final pdfController = controller.pdfController.value;
      if (pdfController == null) {
        return const SizedBox.shrink();
      }

      return AspectRatio(
        aspectRatio: 1.4142 / 1,
        child: Container(
          color: Colors.green.withOpacity(0.2),
          child: LayoutBuilder(builder: (context, constraints) {
            final canvasWidth = constraints.maxWidth;
            final canvasHeight = constraints.maxHeight;

            return Stack(
              children: [
                InteractiveViewer(
                  child: PdfView(
                    controller: pdfController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (newPage) => controller.page.value = newPage,
                  ),
                ),
                BlueprintCanvas(
                  width: canvasWidth,
                  height: canvasHeight,
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}

class _PreviousButton extends StatelessWidget {
  const _PreviousButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintPdfController>();

      return Visibility(
        visible: !Get.find<BlueprintPdfController>().isFirstPage,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: TextButton(
          onPressed: () => controller.previousPage(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
            minimumSize: const Size(56, 56),
            maximumSize: const Size(56, 56),
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Icon(Icons.chevron_left_rounded),
        ),
      );
    });
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintPdfController>();

      return Visibility(
        visible: !Get.find<BlueprintPdfController>().isLastPage,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: TextButton(
          onPressed: () => controller.nextPage(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
            minimumSize: const Size(56, 56),
            maximumSize: const Size(56, 56),
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Icon(Icons.chevron_right_rounded),
        ),
      );
    });
  }
}
