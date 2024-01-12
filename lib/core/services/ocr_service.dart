import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:arkitekt/core/config/logger_custom.dart';
import 'package:pdfx/pdfx.dart';

import '../../modules/domain/highlight_rect.dart';

typedef ApplyOCRResult = (Uint8List image, dynamic output);

class OcrService {
  static final tempDir = Directory.systemTemp.path;
  static final mainDir = '$tempDir\\architekt_ocr';
  static final scriptDir = '$mainDir\\architekt_ocr-master';
  static final ocrPy = '$scriptDir\\main.py';
  static final pdfUtilPy = '$scriptDir\\pdf_utils.py';

  Future<void> _extractPdf({
    required String tempDirectory,
    required PdfDocument document,
    required int page,
  }) async {
    final res = await Process.run('python', [
      pdfUtilPy,
      document.sourceName.substring(5),
      '$page',
      '${page + 1}',
      tempDirectory,
    ]);

    final error = res.stderr as String;
    if (error.isNotEmpty) {
      throw Exception(error);
    }
  }

  Future<void> _applyOcr({
    required String tempDirectory,
    required int page,
  }) async {
    final res = await Process.run('python', [
      ocrPy,
      '$tempDirectory/${page}_1.png',
      '$tempDirectory/output.json',
    ]);

    final error = res.stderr as String;
    if (error.isNotEmpty) {
      throw Exception(error);
    }
  }

  Future<void> _createInput({
    required String tempDirectory,
    required List<HighlightRect> rects,
  }) async {
    try {
      final jsonFile = File('$tempDirectory\\input.json');
      final jsonData = rects.map((rect) => rect.toJson()).toList();
      logger.wtf(jsonData);

      await jsonFile.writeAsString(json.encode(jsonData));
    } catch (e) {
      rethrow;
    }
  }

  Future<ApplyOCRResult> applyOcr({
    required PdfDocument document,
    required int page,
    required List<HighlightRect> rects,
  }) async {
    final directory = '$tempDir\\${DateTime.now().microsecondsSinceEpoch}';
    Directory(directory).createSync(recursive: true);

    logger.wtf(directory);
    try {
      await _createInput(
        tempDirectory: directory,
        rects: rects,
      );

      await _extractPdf(
        tempDirectory: directory,
        document: document,
        page: page,
      );

      await _applyOcr(
        tempDirectory: directory,
        page: page,
      );

      final image = await File('$directory\\${page}_1.png').readAsBytes();
      final output = await File('$directory\\output.json').readAsString();

      return (image, jsonDecode(output));
    } catch (e) {
      rethrow;
    } finally {
      // await Directory(directory).delete(recursive: true);
    }
  }
}
