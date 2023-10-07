import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

import '../../core/config/logger_custom.dart';
import '../../core/services/ocr_service.dart';
import '../../core/utils/async_value.dart';

class ApplyOcrController {
  final stateValue = AsyncValue<ApplyOCRResult?>.data(null).obs;
  ApplyOCRResult? get value => stateValue.value.dataOrNull;
  AsyncValue<ApplyOCRResult?> get state => stateValue.value;

  Future<void> applyOcr({
    required PdfDocument document,
    required int page,
  }) async {
    stateValue.value = const AsyncLoading();

    try {
      final result = await OcrService().applyOcr(
        document: document,
        page: page,
      );
      stateValue.value = AsyncData(result);
    } catch (e, stack) {
      String message = e.toString();
      stateValue.value = AsyncError(e.toString());
      logger.e(message, error: e, stackTrace: stack);
    }
  }
}
