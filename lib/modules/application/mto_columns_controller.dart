import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ocr_local_api.dart';
import '../domain/mto_columns.dart';

part 'mto_columns_controller.g.dart';

@riverpod
class MtoColumnsController extends _$MtoColumnsController {
  @override
  Future<List<MtoColumns>> build() async {
    final ocrLocalApi = ref.read(ocrLocalApiProvider);
    final result = await ocrLocalApi.getColumnsMto();
    return result.fold(
      left: (l) => throw l,
      right: (r) => r,
    );
  }
}
