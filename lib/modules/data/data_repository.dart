import 'package:arkitekt/core/utils/types.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/config/database_helper.dart';
import '../domain/m_t_o_fields.dart';
import '../domain/m_t_o.dart';

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
      orderBy_ = '${orderBy.column} ${orderBy.ascending ? 'ASC' : 'DESC'}';
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
}
