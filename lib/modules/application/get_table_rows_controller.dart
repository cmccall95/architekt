import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/config/logger_custom.dart';
import '../../core/controllers/database_controller.dart';
import '../domain/a_i_s_table_data.dart';

part 'get_table_rows_controller.g.dart';

@riverpod
class GetTableRowsController extends _$GetTableRowsController {
  late final Database database;
  final limit = 20;

  int offset = 0;
  bool isLastPage = false;

  @override
  AsyncValue<List<AISTableData>> build(String tableName) {
    final database_ = ref.watch(databaseControllerProvider);
    switch (database_) {
      case AsyncData(:final value):
        database = value;
        Future.delayed(Duration.zero, fetchFirstBatch);
        return const AsyncLoading();
      case AsyncError(:final error):
        throw error;
      default:
        return const AsyncLoading();
    }
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const AsyncLoading();

      final res = await database.query(
        tableName,
        limit: limit,
        offset: 0,
      );

      isLastPage = res.length < limit;
      offset = res.length;

      final data = res.map((row) => AISTableData.fromJson(row)).toList();
      state = AsyncData(data);
    } catch (e, stack) {
      logger.e('Error fetching first batch\n$e', stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> fetchNextBatch() async {
    final provider = getTableRowsPaginationProvider(tableName);
    final notifier = ref.read(provider.notifier);

    switch (state) {
      case AsyncError():
        ref.invalidateSelf();
      case AsyncData(:final value):
        if (isLastPage) {
          return;
        }

        try {
          notifier.state = const AsyncLoading();

          final res = await database.query(
            tableName,
            limit: limit,
            offset: offset,
          );

          isLastPage = res.length < limit;
          offset += res.length;

          final data = res.map((row) => AISTableData.fromJson(row)).toList();
          state = AsyncData([...value, ...data]);
          notifier.state = AsyncData(!isLastPage);
        } catch (e, stack) {
          logger.e('Error fetching next batch\n$e', stackTrace: stack);
          notifier.state = AsyncError(e, stack);
        }
    }
  }
}

@riverpod
class GetTableRowsPagination extends _$GetTableRowsPagination {
  @override
  set state(AsyncValue<bool> value) => super.state = value;

  @override
  AsyncValue<bool> build(String tableName) {
    final provider = getTableRowsControllerProvider(tableName);
    final data = ref.watch(provider);

    switch (data) {
      case AsyncError(:final error, :final stackTrace):
        return AsyncError(error, stackTrace);
      case AsyncData():
        final notifier = ref.read(provider.notifier);
        return AsyncData(!notifier.isLastPage);
      default:
        return const AsyncLoading();
    }
  }

  void fetchNextBatch() {
    final provider = getTableRowsControllerProvider(tableName);
    final notifier = ref.read(provider.notifier);
    notifier.fetchNextBatch();
  }
}
