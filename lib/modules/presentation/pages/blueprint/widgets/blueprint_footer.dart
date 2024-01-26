import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../application/apply_ocr_controller.dart';
import '../../../../application/blueprint_pdf_controller.dart';
import '../../../../application/region_list_controller.dart';

class BlueprintFooter extends ConsumerWidget {
  const BlueprintFooter({super.key});

  void _applyOcr({
    required WidgetRef ref,
  }) {
    final regions = ref.read(regionListControllerProvider);

    final controller = Get.find<BlueprintPdfController>();
    final document = controller.document.value;
    if (document == null) return;

    final notifier = ref.read(applyOcrControllerProvider.notifier);
    notifier.applyOcr(
      document: document,
      regions: regions,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onPressed: () => _applyOcr(ref: ref),
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
      final pdfController = controller.pdfController.value;

      return Visibility(
        visible: document != null,
        child: Center(
          child: Text(
            'page $page of ${pdfController?.pagesCount ?? 0}',
          ),
        ),
      );
    });
  }
}
