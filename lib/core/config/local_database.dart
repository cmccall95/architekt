import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/domain/dwg_file.dart';
import '../../modules/domain/mto_columns.dart';

part 'local_database.g.dart';

@Riverpod(keepAlive: true)
LocalDatabase localDatabase(LocalDatabaseRef ref) {
  return LocalDatabase();
}

class LocalDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'architekt.db');

    // For testing purposes, delete the database
    await _deleteDatabase();
    return openDatabase(dbPath, version: 1, onCreate: _onCreateDatabase);
  }

  Future<void> _deleteDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'architekt.db');
    await deleteDatabase(dbPath);
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBTables.dwgFile.value} (
        ${DwgFileFieldId.id.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DwgFileFieldId.name.fieldId} TEXT,
        ${DwgFileFieldId.path.fieldId} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DBTables.mto.value} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MtoColumns.pdfPage.fieldId} INTEGER,
        ${MtoColumns.projectId.fieldId} TEXT,
        ${MtoColumns.projectName.fieldId} TEXT,
        ${MtoColumns.lineNumber.fieldId} TEXT,
        ${MtoColumns.drawing.fieldId} TEXT,
        ${MtoColumns.sheet.fieldId} TEXT,
        ${MtoColumns.ofSheet.fieldId} TEXT,
        ${MtoColumns.area.fieldId} TEXT,
        ${MtoColumns.unit.fieldId} TEXT,
        ${MtoColumns.revision.fieldId} TEXT,
        ${MtoColumns.sequence.fieldId} TEXT,
        ${MtoColumns.processUnit.fieldId} TEXT,
        ${MtoColumns.service.fieldId} TEXT,
        ${MtoColumns.system.fieldId} TEXT,
        ${MtoColumns.pAndId.fieldId} TEXT,
        ${MtoColumns.mediumCode.fieldId} TEXT,
        ${MtoColumns.pipeSpec.fieldId} TEXT,
        ${MtoColumns.insulationSpec.fieldId} TEXT,
        ${MtoColumns.paintSpec.fieldId} TEXT,
        ${MtoColumns.insulationThickness.fieldId} TEXT,
        ${MtoColumns.heatTrace.fieldId} TEXT,
        ${MtoColumns.pwht.fieldId} TEXT,
        ${MtoColumns.designCode.fieldId} TEXT,
        ${MtoColumns.pipeStandard.fieldId} TEXT,
        ${MtoColumns.processLineList.fieldId} TEXT,
        ${MtoColumns.vendorDocumentId.fieldId} TEXT,
        ${MtoColumns.xray.fieldId} TEXT,
        ${MtoColumns.weldId.fieldId} TEXT,
        ${MtoColumns.document.fieldId} TEXT,
        ${MtoColumns.documentDescription.fieldId} TEXT,
        ${MtoColumns.documentId.fieldId} TEXT,
        ${MtoColumns.documentTitle.fieldId} TEXT,
        ${MtoColumns.clientDocumentId.fieldId} TEXT,
        ${MtoColumns.averageElevation.fieldId} TEXT,
        ${MtoColumns.maxElevation.fieldId} TEXT,
        ${MtoColumns.minElevation.fieldId} TEXT,
        ${MtoColumns.elevation.fieldId} TEXT,
        ${MtoColumns.pos.fieldId} TEXT,
        ${MtoColumns.materialDescription.fieldId} TEXT,
        ${MtoColumns.npsOd.fieldId} TEXT,
        ${MtoColumns.npsId.fieldId} TEXT,
        ${MtoColumns.ident.fieldId} TEXT,
        ${MtoColumns.item.fieldId} TEXT,
        ${MtoColumns.tag.fieldId} TEXT,
        ${MtoColumns.quantity.fieldId} TEXT,
        ${MtoColumns.cutPieceNo.fieldId} TEXT,
        ${MtoColumns.length.fieldId} TEXT,
        ${MtoColumns.spoolNumber.fieldId} TEXT,
        ${MtoColumns.dp1.fieldId} TEXT,
        ${MtoColumns.dp2.fieldId} TEXT,
        ${MtoColumns.dt1.fieldId} TEXT,
        ${MtoColumns.dt2.fieldId} TEXT,
        ${MtoColumns.op1.fieldId} TEXT,
        ${MtoColumns.op2.fieldId} TEXT,
        ${MtoColumns.opt1.fieldId} TEXT,
        ${MtoColumns.opt2.fieldId} TEXT,
        ${MtoColumns.coating.fieldId} TEXT,
        ${MtoColumns.forging.fieldId} TEXT,
        ${MtoColumns.ends.fieldId} TEXT,
        ${MtoColumns.weldType.fieldId} TEXT,
        ${MtoColumns.additionalInformation.fieldId} TEXT,
        ${MtoColumns.excludeFromRfq.fieldId} TEXT,
        ${MtoColumns.takeoffNotes.fieldId} TEXT,
        ${MtoColumns.generalCategory.fieldId} TEXT,
        ${MtoColumns.rfqScope.fieldId} TEXT,
        ${MtoColumns.size1.fieldId} TEXT,
        ${MtoColumns.size2.fieldId} TEXT,
        ${MtoColumns.schedule.fieldId} TEXT,
        ${MtoColumns.rating.fieldId} TEXT,
        ${MtoColumns.astm.fieldId} TEXT,
        ${MtoColumns.grade.fieldId} TEXT,
        ${MtoColumns.asmeAnsi.fieldId} TEXT,
        ${MtoColumns.material.fieldId} TEXT,
        ${MtoColumns.coordinate.fieldId} TEXT,
        ${MtoColumns.sysBuild.fieldId} TEXT,
        ${MtoColumns.sysFilename.fieldId} TEXT,
        ${MtoColumns.sysPath.fieldId} TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE ${DBTables.generalData.value} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MtoColumns.pdfPage.fieldId} INTEGER,
        ${MtoColumns.projectId.fieldId} TEXT,
        ${MtoColumns.projectName.fieldId} TEXT,
        ${MtoColumns.lineNumber.fieldId} TEXT,
        ${MtoColumns.drawing.fieldId} TEXT,
        ${MtoColumns.sheet.fieldId} TEXT,
        ${MtoColumns.ofSheet.fieldId} TEXT,
        ${MtoColumns.area.fieldId} TEXT,
        ${MtoColumns.unit.fieldId} TEXT,
        ${MtoColumns.revision.fieldId} TEXT,
        ${MtoColumns.sequence.fieldId} TEXT,
        ${MtoColumns.processUnit.fieldId} TEXT,
        ${MtoColumns.service.fieldId} TEXT,
        ${MtoColumns.system.fieldId} TEXT,
        ${MtoColumns.pAndId.fieldId} TEXT,
        ${MtoColumns.mediumCode.fieldId} TEXT,
        ${MtoColumns.pipeSpec.fieldId} TEXT,
        ${MtoColumns.insulationSpec.fieldId} TEXT,
        ${MtoColumns.paintSpec.fieldId} TEXT,
        ${MtoColumns.insulationThickness.fieldId} TEXT,
        ${MtoColumns.heatTrace.fieldId} TEXT,
        ${MtoColumns.pwht.fieldId} TEXT,
        ${MtoColumns.designCode.fieldId} TEXT,
        ${MtoColumns.pipeStandard.fieldId} TEXT,
        ${MtoColumns.processLineList.fieldId} TEXT,
        ${MtoColumns.vendorDocumentId.fieldId} TEXT,
        ${MtoColumns.xray.fieldId} TEXT,
        ${MtoColumns.weldId.fieldId} TEXT,
        ${MtoColumns.document.fieldId} TEXT,
        ${MtoColumns.documentDescription.fieldId} TEXT,
        ${MtoColumns.documentId.fieldId} TEXT,
        ${MtoColumns.documentTitle.fieldId} TEXT,
        ${MtoColumns.clientDocumentId.fieldId} TEXT,
        ${MtoColumns.averageElevation.fieldId} TEXT,
        ${MtoColumns.maxElevation.fieldId} TEXT,
        ${MtoColumns.minElevation.fieldId} TEXT,
        ${MtoColumns.elevation.fieldId} TEXT,
        ${MtoColumns.pos.fieldId} TEXT,
        ${MtoColumns.materialDescription.fieldId} TEXT,
        ${MtoColumns.npsOd.fieldId} TEXT,
        ${MtoColumns.npsId.fieldId} TEXT,
        ${MtoColumns.ident.fieldId} TEXT,
        ${MtoColumns.item.fieldId} TEXT,
        ${MtoColumns.tag.fieldId} TEXT,
        ${MtoColumns.quantity.fieldId} TEXT,
        ${MtoColumns.cutPieceNo.fieldId} TEXT,
        ${MtoColumns.length.fieldId} TEXT,
        ${MtoColumns.spoolNumber.fieldId} TEXT,
        ${MtoColumns.dp1.fieldId} TEXT,
        ${MtoColumns.dp2.fieldId} TEXT,
        ${MtoColumns.dt1.fieldId} TEXT,
        ${MtoColumns.dt2.fieldId} TEXT,
        ${MtoColumns.op1.fieldId} TEXT,
        ${MtoColumns.op2.fieldId} TEXT,
        ${MtoColumns.opt1.fieldId} TEXT,
        ${MtoColumns.opt2.fieldId} TEXT,
        ${MtoColumns.coating.fieldId} TEXT,
        ${MtoColumns.forging.fieldId} TEXT,
        ${MtoColumns.ends.fieldId} TEXT,
        ${MtoColumns.weldType.fieldId} TEXT,
        ${MtoColumns.additionalInformation.fieldId} TEXT,
        ${MtoColumns.excludeFromRfq.fieldId} TEXT,
        ${MtoColumns.takeoffNotes.fieldId} TEXT,
        ${MtoColumns.generalCategory.fieldId} TEXT,
        ${MtoColumns.rfqScope.fieldId} TEXT,
        ${MtoColumns.size1.fieldId} TEXT,
        ${MtoColumns.size2.fieldId} TEXT,
        ${MtoColumns.schedule.fieldId} TEXT,
        ${MtoColumns.rating.fieldId} TEXT,
        ${MtoColumns.astm.fieldId} TEXT,
        ${MtoColumns.grade.fieldId} TEXT,
        ${MtoColumns.asmeAnsi.fieldId} TEXT,
        ${MtoColumns.material.fieldId} TEXT,
        ${MtoColumns.coordinate.fieldId} TEXT,
        ${MtoColumns.sysBuild.fieldId} TEXT,
        ${MtoColumns.sysFilename.fieldId} TEXT,
        ${MtoColumns.sysPath.fieldId} TEXT
      )
      ''');
  }
}

enum DBTables {
  project('project'),
  dwgFile('dwg_file'),
  roi('roi'),
  roiChild('roi_child'),
  mto('mto'),
  mtoCustomization('mto_customization'),
  piping('piping'),
  generalData('general_data'),
  ;

  const DBTables(this.value);
  final String value;
}
