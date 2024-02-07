import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/logger_custom.dart';
import '../data/ocr_local_api.dart';

part 'export_excel_controller.g.dart';

@riverpod
class ExportExcelController extends _$ExportExcelController {
  @override
  AsyncValue<File?> build() {
    return const AsyncData(null);
  }

  Future<void> exportToXlsx() async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(ocrLocalApiProvider);

      final getExportData_ = await repository.getExportData();
      final exportData = getExportData_.fold(
        left: (l) => throw l,
        right: (r) => r,
      );

      var excel = Excel.createExcel();

      Sheet mtoDataSheet = excel['MTO Data'];
      Sheet generalDataSheet = excel['General Data'];

      final mtoRows = exportData.buildMtoRows();
      final generalRows = exportData.buildGeneralRows();

      for (var mto in mtoRows) {
        final cells = mto.map((e) => TextCellValue(e)).toList();
        mtoDataSheet.appendRow(cells);
      }

      for (var general in generalRows) {
        final cells = general.map((e) => TextCellValue(e)).toList();
        generalDataSheet.appendRow(cells);
      }

      final path = await FilePicker.platform.saveFile(
        fileName: 'export.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (path == null) {
        state = const AsyncData(null);
        return;
      }

      final bytes = excel.encode();
      if (bytes == null) {
        state = AsyncError('Failed to encode file', StackTrace.current);
        return;
      }

      final file = File(path);
      final file_ = await file.writeAsBytes(bytes);

      state = AsyncData(file_);
    } on String catch (e) {
      state = AsyncError(e, StackTrace.current);
    } catch (e, stack) {
      logger.e('Error exporting to xlsx\n$e', stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }
}
