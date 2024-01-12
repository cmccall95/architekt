import 'package:arkitekt/modules/application/blueprint_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/config/logger_custom.dart';
import '../../../../application/apply_ocr_controller.dart';
import '../../../../application/blueprint_pdf_controller.dart';

class BlueprintFooter extends StatelessWidget {
  const BlueprintFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        const _DocumentPageCounter(),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {
            // final controller = Get.find<BlueprintController>();
            // logger.wtf(
            //   controller.highlightRects
            //       .map((element) => element.toJson())
            //       .toList(),
            // );

            final controller = Get.find<BlueprintPdfController>();
            final document = controller.document.value;
            if (document == null) return;

            Get.find<ApplyOcrController>().applyOcr(
              document: document,
              page: controller.page.value,
              rects: Get.find<BlueprintController>().highlightRects,
            );
          },
          label: const Text('Apply OCR'),
          icon: const Icon(Icons.auto_fix_high_rounded),
        )
      ]),
    );
  }
}

class _DocumentPageCounter extends StatelessWidget {
  const _DocumentPageCounter();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<BlueprintPdfController>();
      final document = controller.document.value;
      final page = controller.page.value;

      return Visibility(
        visible: document != null,
        child: Center(
          child: Text(
            'page $page of ${document?.pagesCount ?? 0}',
          ),
        ),
      );
    });
  }
}
