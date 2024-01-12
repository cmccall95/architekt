import 'package:arkitekt/modules/application/load_ocr_libraries.dart';
import 'package:get/get.dart';

class LoadScriptsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoadOcrLibraries());
  }
}
