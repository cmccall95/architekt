import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../core/utils/extensions/global_key.dart';
import '../../../application/apply_ocr_controller.dart';
import '../../../application/blueprint_pdf_controller.dart';
import '../../../application/create_region_controller.dart';
import '../../../application/region_index_controller.dart';
import '../../../application/region_list_controller.dart';
import '../../../domain/m_t_o_fields.dart';
import '../../../domain/region.dart';
import '../../widgets/async_helper.dart';
import '../../widgets/drag_listener.dart';
import '../../widgets/mto_field_selector.dart';
import 'widgets/blueprint_footer.dart';
import 'widgets/exit_app_button.dart';
import 'widgets/pick_document_button.dart';

part 'widgets/_canvas.dart';
part 'widgets/_edit_region_dialog.dart';
part 'widgets/_pdf_preview.dart';
part 'widgets/_region_creator.dart';
part 'widgets/_region_list.dart';
part 'widgets/_region_list_tile.dart';
part 'widgets/_region_painter.dart';
part 'widgets/_region_preview.dart';

class BlueprintPage extends ConsumerWidget {
  const BlueprintPage({Key? key}) : super(key: key);

  void _onApplyOcr({
    required BuildContext context,
    required AsyncValue<void> state,
  }) {
    if (state is AsyncError) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.error.toString()),
          );
        },
      );
    }

    if (state is AsyncData) {
      // final controller = Get.find<BlueprintPdfController>();
      // final document = controller.document.value;

      // Navigator.of(context)
      //   ..pop()
      //   ..push(MaterialPageRoute(
      //     builder: (context) => BlueprintOcrViewer(
      //       page: controller.page.value,
      //       data: document!.data,
      //       image: document.image,
      //       pdfName: document.sourceName.split('\\').last,
      //     ),
      //   ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      applyOcrControllerProvider,
      (_, state) => _onApplyOcr(
        context: context,
        state: state,
      ),
    );

    return AsyncHelper(
      loadingProviders: [applyOcrControllerProvider],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.of(context).pushNamed(Routes.mtoTable);
            },
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Blueprints Reader'),
            actions: const [
              ExitAppButton(),
              SizedBox(width: 12),
              PickDocumentButton(),
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
