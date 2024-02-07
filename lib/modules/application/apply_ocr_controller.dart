import 'dart:convert';
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/env.dart';
import '../../core/config/logger_custom.dart';
import '../../core/utils/extensions/file.dart';
import '../data/ocr_repository.dart';
import '../domain/a_i_s_table.dart';
import '../domain/roi.dart';

part 'apply_ocr_controller.g.dart';

@riverpod
class ApplyOcrController extends _$ApplyOcrController {
  @override
  AsyncValue<List<AISTable>?> build() {
    return const AsyncData(null);
  }

  Future<void> applyOcr({
    required File document,
    required List<Roi> regions,
  }) async {
    state = const AsyncLoading();

    try {
      final pdfPath = await _generatePdfFile(document);
      final coordinatesPath = await _generateCoordinatesFile(regions);
      final payloadOptionsPath = await _generatePayloadOptionsFile();

      final repository = ref.read(ocrRepositoryProvider);
      final result = await repository.applyOcr(
        pdfPath: pdfPath,
        coordinatesPath: coordinatesPath,
        payloadOptionsPath: payloadOptionsPath,
      );

      state = result.fold(
        left: (l) => AsyncError(l, StackTrace.current),
        right: (r) => AsyncData(r),
      );
    } catch (e, stack) {
      state = AsyncError(e.toString(), stack);
      logger.e('Failed to apply ocr: $e', error: e, stackTrace: stack);
    }
  }

  Future<String> _generatePdfFile(File pdf) async {
    try {
      final separator = Platform.pathSeparator;
      final tempDir = Directory.systemTemp.path;
      final newPath = '$tempDir'
          '${separator}AIS_MarkupExtractor'
          '${separator}input'
          '${separator}document.pdf';

      await pdf.copy(newPath);

      return '${Env.inputPathDocker}/document.pdf';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _generateCoordinatesFile(List<Roi> regions) async {
    try {
      final separator = Platform.pathSeparator;
      final tempDir = Directory.systemTemp.path;
      final path = '$tempDir'
          '${separator}AIS_MarkupExtractor'
          '${separator}input'
          '${separator}coordinates.json';

      final jsonFile = File(path);

      final jsonData = regions.map((e) => e.toJson()).toList();
      const jsonEncoder = JsonEncoder.withIndent('  ');
      await jsonFile.writeAsString(jsonEncoder.convert(jsonData));

      return '${Env.inputPathDocker}/${jsonFile.name}';
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _generatePayloadOptionsFile() async {
    try {
      final separator = Platform.pathSeparator;
      final tempDir = Directory.systemTemp.path;
      final path = '$tempDir'
          '${separator}AIS_MarkupExtractor'
          '${separator}input'
          '${separator}payload_options.json';

      final jsonData = {
        "aggregate_cols_general": [
          "elevation",
          "name",
          "title",
        ],
        "keep_cols_general": [
          "sys_build",
          "sys_path",
          "sys_filename",
          "pdf_page",
          "source_filename",
          "modDate",
          "id",
          "image_xref",
          "image_path",
          "coordinates2"
        ],
        "merge_to_bom": [
          "line_number",
          "drawing",
          "sheet",
          "area",
          "rev",
          "p_and_id"
        ],
        "bom_merge_on": [
          "sys_path",
          "pdf_page",
        ]
      };

      final jsonFile = File(path);
      const jsonEncoder = JsonEncoder.withIndent('  ');
      await jsonFile.writeAsString(jsonEncoder.convert(jsonData));
      return '${Env.inputPathDocker}/${jsonFile.name}';
    } catch (e) {
      rethrow;
    }
  }
}
