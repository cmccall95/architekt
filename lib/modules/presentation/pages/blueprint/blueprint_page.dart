import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:arkitekt/modules/presentation/widgets/error_dialog.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../core/config/logger_custom.dart';
import '../../../../core/config/routes.dart';
import '../../../../core/utils/extensions/global_key.dart';
import '../../../application/populate_extraction_controller.dart';
import '../../../application/apply_ocr_controller.dart';
import '../../../application/blueprint_pdf_controller.dart';
import '../../../application/create_region_controller.dart';
import '../../../application/region_index_controller.dart';
import '../../../application/region_list_controller.dart';
import '../../../domain/a_i_s_table.dart';
import '../../../domain/roi.dart';
import '../../../domain/roi_columns.dart';
import '../../widgets/async_helper.dart';
import '../../widgets/drag_listener.dart';
import '../../widgets/field_selector.dart';
import 'widgets/blueprint_footer.dart';

part 'widgets/_canvas.dart';
part 'widgets/_edit_region_dialog.dart';
part 'widgets/_exit_app_button.dart';
part 'widgets/_pdf_preview.dart';
part 'widgets/_pick_document_button.dart';
part 'widgets/_region_creator.dart';
part 'widgets/_region_list.dart';
part 'widgets/_region_list_tile.dart';
part 'widgets/_region_painter.dart';
part 'widgets/_region_preview.dart';

class BlueprintPage extends ConsumerWidget {
  const BlueprintPage({Key? key}) : super(key: key);

  void _onApplyOcr({
    required BuildContext context,
    required WidgetRef ref,
    required AsyncValue<List<AISTable>?> state,
  }) {
    switch (state) {
      case AsyncError(:final error):
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Failed to extract data'),
              content: Text(error.toString()),
            );
          },
        );
      case AsyncData(:final value):
        final provider = populateExtractionControllerProvider;
        final notifier = ref.read(provider.notifier);
        notifier.populateExtraction(
          mtoData: value![0].data,
          generalData: value[1].data,
        );
    }
  }

  void _onAddMtos({
    required BuildContext context,
    required AsyncValue<void> state,
  }) {
    switch (state) {
      case AsyncError(:final error):
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Failed to upload MTOs'),
              content: Text(error.toString()),
            );
          },
        );
      case AsyncData():
        Navigator.of(context).pushNamed(Routes.mtoTable);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      applyOcrControllerProvider,
      (_, state) => _onApplyOcr(
        context: context,
        ref: ref,
        state: state,
      ),
    );

    ref.listen(
      populateExtractionControllerProvider,
      (_, state) => _onAddMtos(
        context: context,
        state: state,
      ),
    );

    return AsyncHelper(
      loadingProviders: [applyOcrControllerProvider],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Blueprints Reader'),
            actions: const [
              _ExitAppButton(),
              SizedBox(width: 12),
              PickDocumentButton(),
              SizedBox(width: 12),
            ],
          ),
          body: const Column(
            children: [
              Expanded(
                child: _PdfPreview(),
              ),
              BlueprintFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
