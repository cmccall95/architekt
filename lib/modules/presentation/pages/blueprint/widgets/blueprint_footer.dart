import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../application/apply_ocr_controller.dart';
import '../../../../application/blueprint_pdf_controller.dart';
import '../../../../application/region_list_controller.dart';

class BlueprintFooter extends ConsumerWidget {
  const BlueprintFooter({super.key});

  void _applyOcr({
    required WidgetRef ref,
  }) {
    final pdf = ref.watch(blueprintPdfControllerProvider);
    final properties = pdf.valueOrNull;
    if (properties == null) return;

    final regions = ref.read(regionListControllerProvider);
    final notifier = ref.read(applyOcrControllerProvider.notifier);
    notifier.applyOcr(
      document: properties.file,
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

class _DocumentPageCounter extends ConsumerWidget {
  const _DocumentPageCounter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(blueprintPdfControllerProvider);
    final properties = pdf.valueOrNull;

    final page = properties?.currentPage ?? 0;
    final pagesCount = properties?.pagesCount ?? 0;

    return Visibility(
      visible: properties != null,
      child: Center(
        child: Text(
          'page $page of $pagesCount',
        ),
      ),
    );
  }
}
