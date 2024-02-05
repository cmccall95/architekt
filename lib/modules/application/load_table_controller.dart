import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/config/logger_custom.dart';
import '../../core/controllers/database_controller.dart';
import '../domain/a_i_s_data.dart';
import '../domain/mto_columns.dart';
import '../domain/a_i_s_table.dart';

part 'load_table_controller.g.dart';

@riverpod
class LoadTableController extends _$LoadTableController {
  late final Database database;

  @override
  Future<void> build(AISTable table) async {
    final database = ref.watch(databaseControllerProvider);
    switch (database) {
      case AsyncData(:final value):
        this.database = value;

        await _createTable(table.name);
        await _populateTable(tableName: table.name, data: table.data);

        return;
      case AsyncError(:final error):
        throw error;
      default:
        return Completer().future;
    }
  }

  Future<void> _populateTable({
    required String tableName,
    required List<AISData> data,
  }) async {
    try {
      for (final item in data) {
        final json = item.toJson();
        await database.insert(tableName, json);
      }
    } catch (e, stack) {
      logger.e('Failed to populate table $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> _createTable(String tableName) async {
    try {
      await database.execute('''
        DROP TABLE IF EXISTS $tableName;
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${MtoColumns.values.map((e) => '${e.fieldId} TEXT').join(', ')}
        )
      ''');
    } catch (e, stack) {
      logger.e('Failed to create table $e', stackTrace: stack);
      rethrow;
    }
  }
}
