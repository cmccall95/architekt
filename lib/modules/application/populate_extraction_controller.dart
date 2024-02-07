import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ocr_local_api.dart';
import '../domain/mto.dart';

part 'populate_extraction_controller.g.dart';

@riverpod
class PopulateExtractionController extends _$PopulateExtractionController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> populateExtraction({
    required List<Mto> mtoData,
    required List<Mto> generalData,
  }) async {
    state = const AsyncLoading();
    try {
      final ocrLocalApi = ref.read(ocrLocalApiProvider);
      final res = await ocrLocalApi.populateExtractedData(
        mtoData: mtoData,
        generalData: generalData,
      );

      state = res.fold(
        left: (l) => AsyncError(l, StackTrace.current),
        right: (r) => const AsyncData(null),
      );
    } catch (e, stack) {
      state = AsyncError(e.toString(), stack);
    }
  }
}
