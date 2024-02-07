import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/logger_custom.dart';
import '../../core/utils/either.dart';
import '../data/ocr_local_api.dart';
import '../domain/a_i_s_table_data.dart';

part 'get_general_data_controller.g.dart';

@riverpod
class GetGeneralDataController extends _$GetGeneralDataController {
  final limit = 50;

  int offset = 0;
  bool isLastPage = false;

  @override
  AsyncValue<List<AISTableData>> build() {
    Future.delayed(Duration.zero, fetchFirstBatch);
    return const AsyncLoading();
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const AsyncLoading();

      final repository = ref.watch(ocrLocalApiProvider);
      final res = await repository.getGeneralData(limit: limit, offset: 0);

      switch (res) {
        case Left(:final value):
          state = AsyncError(value, StackTrace.current);
        case Right(:final value):
          isLastPage = value.length < limit;
          offset = value.length;

          state = AsyncData(value);
      }
    } catch (e, stack) {
      logger.e('Error fetching first batch\n$e', stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> fetchNextBatch() async {
    final notifier = ref.read(getGeneralDataPaginationProvider.notifier);
    switch (state) {
      case AsyncError():
        ref.invalidateSelf();
      case AsyncData(value: final currState):
        if (isLastPage) {
          return;
        }

        try {
          notifier.state = const AsyncLoading();

          final repository = ref.watch(ocrLocalApiProvider);
          final res = await repository.getGeneralData(
            limit: limit,
            offset: offset,
          );

          switch (res) {
            case Left(:final value):
              notifier.state = AsyncError(value, StackTrace.current);
            case Right(:final value):
              isLastPage = value.length < limit;
              offset += value.length;

              state = AsyncData([...currState, ...value]);
              notifier.state = AsyncData(!isLastPage);
          }
        } catch (e, stack) {
          logger.e('Error fetching next batch\n$e', stackTrace: stack);
          notifier.state = AsyncError(e, stack);
        }
    }
  }
}

@riverpod
class GetGeneralDataPagination extends _$GetGeneralDataPagination {
  @override
  set state(AsyncValue<bool> value) => super.state = value;

  @override
  AsyncValue<bool> build() {
    final data = ref.watch(getGeneralDataControllerProvider);

    switch (data) {
      case AsyncError(:final error, :final stackTrace):
        return AsyncError(error, stackTrace);
      case AsyncData():
        final notifier = ref.read(getGeneralDataControllerProvider.notifier);
        return AsyncData(!notifier.isLastPage);
      default:
        return const AsyncLoading();
    }
  }

  void fetchNextBatch() {
    final notifier = ref.read(getGeneralDataControllerProvider.notifier);
    notifier.fetchNextBatch();
  }
}
