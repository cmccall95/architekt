import 'package:get/get.dart';

import '../../core/config/logger_custom.dart';
import '../../core/utils/async_value.dart';
import '../data/data_repository.dart';
import '../domain/m_t_o_fields.dart';

class GenerateMTOGroupedController extends GetxController {
  final stateValue = AsyncValue<void>.data(null).obs;
  void get value => stateValue.value.dataOrNull;
  AsyncValue<void> get state => stateValue.value;

  @override
  void onInit() {
    super.onInit();
    generateMTOGrouped();
  }

  Future<void> generateMTOGrouped() async {
    stateValue.value = AsyncValue.loading();
    try {
      await DataRepository().groupMTOByColumn(MTOField.pipeSpec);
      stateValue.value = AsyncValue.data(null);
    } catch (e, stack) {
      const message = 'Error grouping MTOs';

      stateValue.value = AsyncValue.error(message);
      logger.e(message, error: e, stackTrace: stack);
    }
  }
}
