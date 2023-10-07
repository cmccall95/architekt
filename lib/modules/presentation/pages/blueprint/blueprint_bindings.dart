import 'package:arkitekt/modules/application/apply_ocr_controller.dart';
import 'package:get/get.dart';

import '../../../application/blueprint_pdf_controller.dart';

class BlueprintBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlueprintPdfController());
    Get.lazyPut(() => ApplyOcrController());
  }
}
