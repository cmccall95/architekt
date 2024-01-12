import 'package:sqflite/sqflite.dart';

import '../../core/config/database_helper.dart';
import '../../core/config/logger_custom.dart';
import '../../core/utils/extensions/string.dart';
import '../../core/utils/types.dart';
import '../domain/m_t_o.dart';
import '../domain/m_t_o_fields.dart';

class DataRepository {
  Future<void> mapJsonToDatabase(List<Map<String, dynamic>> json) async {
    final db = await DatabaseHelper.to.database;

    for (var item in json) {
      await db.insert(
        DataBaseTables.mto.value,
        item,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<MTO>> getMTOs({
    int? offset,
    int? limit,
    String? query,
    MTOField? queryBy,
    OrderBy? orderBy,
  }) async {
    final db = await DatabaseHelper.to.database;

    String? orderBy_;
    if (orderBy != null) {
      orderBy_ =
          '${orderBy.column.value} ${orderBy.ascending ? 'ASC' : 'DESC'}';
    }

    String? where;
    List<String>? whereArgs;
    if (queryBy != null && query != null) {
      where = '${queryBy.value} LIKE ?';
      whereArgs = ['%$query%'];
    }

    final queryResult = await db.query(
      DataBaseTables.mto.value,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy_,
      limit: limit,
      offset: offset,
    );

    return queryResult.map((row) => MTO.fromJson(row)).toList();
  }

  Future<void> updateMTO(MTO updatedMTO) async {
    final db = await DatabaseHelper.to.database;

    final res = await db.update(
      DataBaseTables.mto.value,
      updatedMTO.toJson(),
      where: 'database_id = ?',
      whereArgs: [updatedMTO.databaseId],
    );

    if (res == 0) {
      throw 'Failed to update row';
    }
  }

  Future<List<MTO>> groupByColumn({
    required MTOField column,
    int? limit = 10,
    int? offset = 0,
    OrderBy? orderBy,
  }) async {
    final db = await DatabaseHelper.to.database;

    String? orderBy_;
    if (orderBy != null) {
      orderBy_ = '${orderBy.column} ${orderBy.ascending ? 'ASC' : 'DESC'}';
    }

    final res = await db.rawQuery('''
      SELECT ${column.value}, COUNT(*) as count
      FROM ${DataBaseTables.mto.value}
      GROUP BY ${column.value}
      LIMIT $limit OFFSET $offset
    ''');

    logger.i(res);

    return res.map((row) {
      final quantityColumn = row[MTOField.quantity.value].toString();
      final quantity = quantityColumn.toInt ?? 0;
      final count = row['count'].toString().toInt ?? 0;

      final row_ = {...row, MTOField.quantity.value: '${quantity + count}'};
      return MTO.fromJson(row_);
    }).toList();
  }

  Future<void> groupMTOByColumn(MTOField column) async {
    final db = await DatabaseHelper.to.database;
    await db.transaction((txn) async {
      await txn.execute(
        'DROP TABLE IF EXISTS ${DataBaseTables.mtoGrouped.value}',
      );

      await txn.execute('''
      CREATE TABLE ${DataBaseTables.mtoGrouped.value} AS
      SELECT *, COUNT(*) OVER(PARTITION BY ${column.value}) as database_count
      FROM ${DataBaseTables.mto.value}
    ''');
    });
  }

  Future<List<MTO>> getMTOGrouped({
    required MTOField column,
    int? limit = 10,
    int? offset = 0,
    OrderBy? orderBy,
  }) async {
    final db = await DatabaseHelper.to.database;

    String? orderBy_;
    if (orderBy != null) {
      orderBy_ = '${orderBy.column} ${orderBy.ascending ? 'ASC' : 'DESC'}';
    }

    // final queryResult = await db.query(
    //   DataBaseTables.mtoGrouped.value,
    //   orderBy: orderBy_,
    //   limit: limit,
    //   offset: offset,
    // );

    final res = await db.rawQuery('''
      SELECT ${column.value}, SUM(database_id) AS ${MTOField.sheet.value}, COUNT(*) AS ${MTOField.lineNumber.value}
      FROM ${DataBaseTables.mto.value}
      GROUP BY ${column.value}
      LIMIT $limit OFFSET $offset
    ''');

    logger.wtf(res);

    return res.map((row) => MTO.fromJson(row)).toList();
  }
}
