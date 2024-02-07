import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ocr_local_api.dart';
import '../domain/mto_columns.dart';

part 'general_data_columns_controller.g.dart';

@riverpod
class GeneralDataColumnsController extends _$GeneralDataColumnsController {
  @override
  Future<List<MtoColumns>> build() async {
    final ocrLocalApi = ref.read(ocrLocalApiProvider);
    final result = await ocrLocalApi.getColumnsGeneralData();
    return result.fold(
      left: (l) => throw l,
      right: (r) => r,
    );
  }
}
