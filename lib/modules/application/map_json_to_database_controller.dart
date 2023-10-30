import 'package:get/get.dart';

import '../../core/config/logger_custom.dart';
import '../../core/utils/async_value.dart';
import '../data/data_repository.dart';

class MapJsonToDatabaseController {
  final stateValue = AsyncValue<void>.data(null).obs;
  void get value => stateValue.value.dataOrNull;
  AsyncValue<void> get state => stateValue.value;

  Future<void> mapJsonToDatabase(List<Map<String, dynamic>> json) async {
    stateValue.value = const AsyncLoading();

    try {
      await DataRepository().mapJsonToDatabase(json);
      stateValue.value = const AsyncData(null);
    } catch (e, stack) {
      String message = e.toString();
      stateValue.value = AsyncError(e.toString());
      logger.e(message, error: e, stackTrace: stack);
    }
  }
}
