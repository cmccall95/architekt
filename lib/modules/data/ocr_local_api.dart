import 'package:arkitekt/modules/domain/export_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/config/local_database.dart';
import '../../core/config/logger_custom.dart';
import '../../core/utils/either.dart';
import '../domain/a_i_s_table_data.dart';
import '../domain/mto.dart';
import '../domain/mto_columns.dart';

part 'ocr_local_api.g.dart';

@riverpod
OcrLocalApi ocrLocalApi(OcrLocalApiRef ref) {
  return OcrLocalApi(localDatabase: ref.watch(localDatabaseProvider));
}

class OcrLocalApi {
  OcrLocalApi({required this.localDatabase});

  final LocalDatabase localDatabase;

  Future<Either<String, List<MtoColumns>>> getColumnsMto() async {
    try {
      final db = await localDatabase.database;
      final tableInfo = await db.rawQuery('''
        PRAGMA table_info(${DBTables.mto.value})
      ''');

      List<MtoColumns> columnsWithValues = [];
      for (var columnInfo in tableInfo) {
        final columnName = columnInfo['name'];

        if (columnName == "id") continue;
        if (columnName == MtoColumns.sysBuild.fieldId) continue;
        if (columnName == MtoColumns.sysFilename.fieldId) continue;
        if (columnName == MtoColumns.sysPath.fieldId) continue;
        if (columnName == MtoColumns.coordinate.fieldId) continue;

        final count = Sqflite.firstIntValue(await db.rawQuery('''
          SELECT COUNT(*) FROM ${DBTables.mto.value} WHERE $columnName IS NOT NULL
        '''));

        if (count == null || count <= 0) continue;
        columnsWithValues.add(MtoColumns.fromString('$columnName'));
      }

      return Right(columnsWithValues);
    } catch (e, stack) {
      logger.e('Failed to get non empty columns $e', stackTrace: stack);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<MtoColumns>>> getColumnsGeneralData() async {
    try {
      final db = await localDatabase.database;
      final tableInfo = await db.rawQuery('''
        PRAGMA table_info(${DBTables.generalData.value})
      ''');

      List<MtoColumns> columnsWithValues = [];
      for (var columnInfo in tableInfo) {
        final columnName = columnInfo['name'];

        if (columnName == "id") continue;
        if (columnName == MtoColumns.sysBuild.fieldId) continue;
        if (columnName == MtoColumns.sysFilename.fieldId) continue;
        if (columnName == MtoColumns.sysPath.fieldId) continue;
        if (columnName == MtoColumns.coordinate.fieldId) continue;

        final count = Sqflite.firstIntValue(await db.rawQuery('''
          SELECT COUNT(*) FROM ${DBTables.generalData.value} WHERE $columnName IS NOT NULL
        '''));

        if (count == null || count <= 0) continue;
        columnsWithValues.add(MtoColumns.fromString('$columnName'));
      }

      return Right(columnsWithValues);
    } catch (e, stack) {
      logger.e('Failed to get non empty columns $e', stackTrace: stack);
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> populateExtractedData({
    required List<Mto> mtoData,
    required List<Mto> generalData,
  }) async {
    try {
      final db = await localDatabase.database;
      final batch = db.batch();

      batch.delete(DBTables.mto.value);
      batch.delete(DBTables.generalData.value);

      for (final item in mtoData) {
        final json = item.toJson();
        batch.insert(DBTables.mto.value, json);
      }

      for (final item in generalData) {
        final json = item.toJson();
        batch.insert(DBTables.generalData.value, json);
      }

      await batch.commit(noResult: true);
      return const Right(null);
    } catch (e, stack) {
      logger.e('Failed to populate extracted data $e', stackTrace: stack);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AISTableData>>> getMtos({
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await localDatabase.database;
      final res = await db.query(
        DBTables.mto.value,
        limit: limit,
        offset: offset,
      );

      final mtos = res.map((row) {
        return AISTableData(
          id: row['id'] as int,
          data: Mto.fromJson(row),
        );
      }).toList();

      return Right(mtos);
    } catch (e, stack) {
      logger.e('Failed to get mtos $e', stackTrace: stack);
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AISTableData>>> getGeneralData({
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await localDatabase.database;
      final res = await db.query(
        DBTables.generalData.value,
        limit: limit,
        offset: offset,
      );

      final mtos = res.map((row) {
        return AISTableData(
          id: row['id'] as int,
          data: Mto.fromJson(row),
        );
      }).toList();

      return Right(mtos);
    } catch (e, stack) {
      logger.e('Failed to get mtos $e', stackTrace: stack);
      return Left(e.toString());
    }
  }

  Future<Either<String, ExportData>> getExportData() async {
    try {
      final db = await localDatabase.database;
      final mtoData = await db.query(DBTables.mto.value);
      final generalData = await db.query(DBTables.generalData.value);

      final getColumnsMto_ = await getColumnsMto();
      final mtoColumns = getColumnsMto_.fold(
        left: (l) => throw getColumnsMto_,
        right: (r) => r,
      );

      final getColumnsGeneralData_ = await getColumnsGeneralData();
      final generalDataColumns = getColumnsGeneralData_.fold(
        left: (l) => throw getColumnsGeneralData_,
        right: (r) => r,
      );

      return Right(ExportData(
        mtoData: mtoData,
        generalData: generalData,
        mtoColumns: mtoColumns,
        generalColumns: generalDataColumns,
      ));
    } on Left {
      rethrow;
    } catch (e, stack) {
      logger.e('Failed to get export data $e', stackTrace: stack);
      return Left(e.toString());
    }
  }
}
