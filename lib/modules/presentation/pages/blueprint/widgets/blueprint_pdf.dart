import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../application/blueprint_pdf_controller.dart';

class BlueprintPdf extends StatelessWidget {
  const BlueprintPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        final controller = Get.find<BlueprintPdfController>();

        final pdfController = controller.pdfController.value;
        if (pdfController == null) {
          return const SizedBox.shrink();
        }

        return Row(
          children: [
            const _PreviousButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: InteractiveViewer(
                  child: PdfView(
                    controller: pdfController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (newPage) => controller.page.value = newPage,
                  ),
                ),
              ),
            ),
            const _NextButton(),
          ],
        );
      }),
    );
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
