import 'package:arkitekt/core/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../application/apply_ocr_controller.dart';
import '../../widgets/async_helper.dart';
import 'widgets/blueprint_footer.dart';
import 'widgets/blueprint_pdf.dart';
import 'widgets/exit_app_button.dart';
import 'widgets/pick_document_button.dart';

class BlueprintPage extends StatefulWidget {
  const BlueprintPage({Key? key}) : super(key: key);

  @override
  State<BlueprintPage> createState() => _BlueprintPageState();
}

class _BlueprintPageState extends State<BlueprintPage> {
  late final Worker _everApplyOcr;

  @override
  void initState() {
    super.initState();

    _everApplyOcr = ever(Get.find<ApplyOcrController>().stateValue, (value) {
      // if (value.hasData && value.dataOrNull != null) {
      //   final controller = Get.find<BlueprintPdfController>();
      //   final (image, output) = value.dataOrNull!;
      //   final document = controller.document.value;

      //   Navigator.of(context)
      //     ..pop()
      //     ..push(MaterialPageRoute(
      //       builder: (context) => BlueprintOcrViewer(
      //         page: controller.page.value,
      //         data: output,
      //         image: image,
      //         pdfName: document!.sourceName.split('\\').last,
      //       ),
      //     ));
      // }
    });
  }

  @override
  void dispose() {
    _everApplyOcr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncHelper(
      loadingObservers: [
        Get.find<ApplyOcrController>().stateValue,
      ],
      errorObservers: [
        Get.find<ApplyOcrController>().stateValue,
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.mtoTable),
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
                child: BlueprintPdf(),
              ),
              BlueprintFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
