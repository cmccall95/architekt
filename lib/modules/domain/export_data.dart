import 'mto_columns.dart';

class ExportData {
  const ExportData({
    required this.mtoData,
    required this.generalData,
    required this.mtoColumns,
    required this.generalColumns,
  });

  final List<Map<String, dynamic>> mtoData;
  final List<Map<String, dynamic>> generalData;
  final List<MtoColumns> mtoColumns;
  final List<MtoColumns> generalColumns;

  List<List<String>> buildMtoRows() {
    final rows = <List<String>>[];

    final columns = mtoColumns.map((e) => e.displayName).toList();
    rows.add(columns);

    for (final data in mtoData) {
      final row = mtoColumns.map((e) {
        return data[e.fieldId]?.toString() ?? "";
      }).toList();

      rows.add(row);
    }

    return rows;
  }

  List<List<String>> buildGeneralRows() {
    final rows = <List<String>>[];

    final columns = generalColumns.map((e) => e.displayName).toList();
    rows.add(columns);

    for (final data in generalData) {
      final row = generalColumns.map((e) {
        return data[e.fieldId]?.toString() ?? "";
      }).toList();

      rows.add(row);
    }

    return rows;
  }
}
