import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/domain/m_t_o_fields.dart';

class DatabaseHelper {
  Database? _database;

  static DatabaseHelper get to => Get.find();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'architekt.db');

    await ((await openDatabase(dbPath)).close());
    await deleteDatabase(dbPath);

    return openDatabase(dbPath, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DataBaseTables.mto.value} (
        database_id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MTOField.id.value} TEXT,
        ${MTOField.drawing.value} TEXT,
        ${MTOField.sheet.value} TEXT,
        ${MTOField.lineNumber.value} TEXT,
        ${MTOField.pipeSpec.value} TEXT,
        ${MTOField.paintSpec.value} TEXT,
        ${MTOField.insulationSpec.value} TEXT,
        ${MTOField.pwht.value} TEXT,
        ${MTOField.pAndId.value} TEXT,
        ${MTOField.area.value} TEXT,
        ${MTOField.item.value} TEXT,
        ${MTOField.tag.value} TEXT,
        ${MTOField.quantity.value} TEXT,
        ${MTOField.nps.value} TEXT,
        ${MTOField.materialDescription.value} TEXT,
        ${MTOField.heatTrace.value} TEXT,
        ${MTOField.insulationType.value} TEXT,
        ${MTOField.insulationThickness.value} TEXT,
        ${MTOField.processLineList.value} TEXT,
        ${MTOField.documents.value} TEXT
      )
    ''');
  }
}

enum DataBaseTables {
  mto('MTO');

  const DataBaseTables(this.value);
  final String value;
}
