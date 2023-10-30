import 'package:get/get.dart';

import '../../core/config/logger_custom.dart';
import '../../core/utils/async_value.dart';
import '../data/data_repository.dart';
import '../domain/m_t_o.dart';

class UpdateMTOController extends GetxController {
  final stateValue = AsyncValue<MTO?>.data(null).obs;
  MTO? get value => stateValue.value.dataOrNull;
  AsyncValue<MTO?> get state => stateValue.value;

  Future<void> updateMTO(MTO mto) async {
    stateValue.value = AsyncValue.loading();
    try {
      await DataRepository().updateMTO(mto);
      stateValue.value = AsyncValue.data(mto);
    } catch (e, stack) {
      final message = 'Error updating ${mto.id}';

      stateValue.value = AsyncValue.error(message);
      logger.e(message, error: e, stackTrace: stack);
    }
  }
}
