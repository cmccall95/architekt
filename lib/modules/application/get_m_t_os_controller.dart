import 'package:get/get.dart';

import '../../core/config/logger_custom.dart';
import '../../core/utils/async_value.dart';
import '../../core/utils/types.dart';
import '../data/data_repository.dart';
import '../domain/m_t_o.dart';

class GetMTOsController extends GetxController {
  final stateValue = AsyncValue<List<MTO>?>.data(null).obs;
  List<MTO>? get value => stateValue.value.dataOrNull;
  AsyncValue<List<MTO>?> get state => stateValue.value;

  final paginationStateValue = AsyncValue<void>.data(null).obs;
  AsyncValue<void> get paginationState => paginationStateValue.value;

  final limit = 20.obs;
  final offset = 0.obs;
  final isLastPage = false.obs;
  final orderBy = Rxn<OrderBy>();

  @override
  void onInit() {
    super.onInit();

    fetchFirstBatch();
  }

  Future<void> fetchFirstBatch() async {
    stateValue.value = AsyncValue.loading();
    try {
      final data = await DataRepository().getMTOs(
        limit: limit.value,
        offset: 0,
        orderBy: orderBy.value,
      );

      isLastPage.value = data.length < limit.value;
      offset.value = data.length;

      stateValue.value = AsyncValue.data(data);
    } catch (e, stack) {
      const message = 'Error fetching first batch';

      stateValue.value = AsyncValue.error(message);
      logger.e(message, error: e, stackTrace: stack);
    }
  }

  Future<void> fetchNextBatch() async {
    paginationStateValue.value = AsyncValue.loading();
    try {
      final data = await DataRepository().getMTOs(
        limit: limit.value,
        offset: offset.value,
        orderBy: orderBy.value,
      );

      isLastPage.value = data.length < limit.value;
      offset.value += data.length;

      stateValue.value = AsyncValue.data([...value!, ...data]);
      paginationStateValue.value = AsyncValue.data(null);
    } catch (e, stack) {
      const message = 'Error fetching next batch';

      paginationStateValue.value = AsyncValue.error(message);
      logger.e(message, error: e, stackTrace: stack);
    }
  }

  void updateMTO(MTO mto) {
    if (value == null) return;

    final index = value!.indexWhere((element) {
      return element.databaseId == mto.databaseId;
    });

    if (index == -1) return;

    value![index] = mto;
    stateValue.value = AsyncValue.data(value!);
  }
}
