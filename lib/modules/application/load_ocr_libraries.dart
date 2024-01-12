import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/config/logger_custom.dart';
import '../../core/services/ocr_service.dart';
import '../../core/utils/async_value.dart';

class LoadOcrLibraries {
  final stateValue = AsyncValue<void>.data(null).obs;
  AsyncValue<void> get state => stateValue.value;

  Future<void> loadLibraries() async {
    stateValue.value = const AsyncLoading();

    try {
      final isDependenciesInstalled = await _checkPythonDependencies();
      if (!isDependenciesInstalled) return;

      final ocrExists = await _checkOcrExists();
      if (!ocrExists) {
        final isDownloaded = await _downloadOcrScripts();
        if (!isDownloaded) return;

        final isUnzipped = await _unzipOcrScripts();
        if (!isUnzipped) return;

        final isRequirementsInstalled = await _installRequirements();
        if (!isRequirementsInstalled) return;
      }

      final isScriptsInstalled = await _checkScripts();
      if (!isScriptsInstalled) return;

      stateValue.value = const AsyncData(null);
    } catch (e, stack) {
      String message = e.toString();
      stateValue.value = AsyncError(e.toString());
      logger.e(message, error: e, stackTrace: stack);
    }
  }

  Future<bool> _checkPythonDependencies() async {
    stateValue.value = const AsyncLoading(
      message: 'Checking Python dependencies',
    );

    try {
      final pythonResult = await Process.run('python', ['--version']);
      if (!pythonResult.stdout.toString().startsWith('Python')) {
        stateValue.value = const AsyncError(
          'Python was not installed on your system, '
          'make sure you install Python before continuing',
        );
        return false;
      }

      final tesseractResult = await Process.run('tesseract', ['--version']);
      if (!tesseractResult.stdout.toString().startsWith('tesseract v5')) {
        stateValue.value = const AsyncError(
          'Tesseract v5 was not installed on your system, '
          'make sure you install Tesseract v5 before continuing',
        );
        return false;
      }

      return true;
    } catch (e) {
      stateValue.value = AsyncError('Failed to check Python dependencies, $e');
      return false;
    }
  }

  Future<bool> _checkOcrExists() async {
    stateValue.value = const AsyncLoading(message: 'Checking OCR Scripts');

    try {
      final mainDir = Directory(OcrService.mainDir);
      final mainDirExists = await mainDir.exists();

      if (!mainDirExists) {
        await mainDir.create(recursive: true);
      }

      final scriptDir = Directory(OcrService.scriptDir);
      final scriptDirExists = await scriptDir.exists();

      return scriptDirExists;
    } catch (e) {
      stateValue.value = AsyncError('Failed to check OCR scripts, $e');
      return false;
    }
  }

  Future<bool> _downloadOcrScripts() async {
    stateValue.value = const AsyncLoading(
      message: 'Downloading OCR Scripts (0%)',
    );

    try {
      const account = 'https://github.com/cmccall95/architekt_ocr';
      const repo = '$account/archive/refs/heads/master.zip';

      await Dio().download(
        repo,
        '${OcrService.mainDir}\\data.zip',
        onReceiveProgress: (received, total) {
          String message;
          double? progress;

          if (total < 0) {
            message = 'Downloading Scripts ${(received / 1000000).round()} Mb';
          } else {
            progress = received / total;
            message = 'Downloading Scripts (${(progress * 100).round()}%)';
          }

          stateValue.value = AsyncLoading(
            message: message,
            progress: progress,
          );
        },
      );

      return true;
    } catch (e) {
      stateValue.value = AsyncError('Failed to download OCR scripts, $e');
      return false;
    }
  }

  Future<bool> _unzipOcrScripts() async {
    stateValue.value = const AsyncLoading(message: 'Unzipping OCR Scripts');

    try {
      final bytes = await File('${OcrService.mainDir}\\data.zip').readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filename = file.name;
        if (!file.isFile) {
          Directory('${OcrService.mainDir}/$filename').create(recursive: true);
          continue;
        }

        final data = file.content as List<int>;
        File('${OcrService.mainDir}/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }

      return true;
    } catch (e) {
      stateValue.value = AsyncError('Failed to unzip OCR scripts, $e');
      return false;
    }
  }

  Future<bool> _installRequirements() async {
    stateValue.value = const AsyncLoading(message: 'Installing OCR Libraries');

    try {
      final result = await Process.run(
        'pip',
        ['install', '-r', '${OcrService.scriptDir}\\requirements.txt'],
      );

      if (result.stderr.toString().startsWith('WARNING')) {
        stateValue.value = AsyncError(
          'Failed to install OCR dependencies, '
          '${result.stderr}',
        );

        return false;
      }

      return true;
    } catch (e) {
      stateValue.value = AsyncError('Failed to install OCR dependencies, $e');
      return false;
    }
  }

  Future<bool> _checkScripts() async {
    try {
      final scriptDir = OcrService.scriptDir;

      final ocrVersion = await Process.run(
        'python',
        ['$scriptDir\\main.py', '--version'],
      );

      if (!ocrVersion.stdout.toString().startsWith('ARKITEKT_OCR v1.0')) {
        stateValue.value = AsyncError(
          'The Scripts are not working on your system '
          'contact developers for more details'
          '\n${ocrVersion.stderr}',
        );

        return false;
      }

      final pdfUtilVersion = await Process.run(
        'python',
        ['$scriptDir\\pdf_utils.py', '--version'],
      );

      if (!pdfUtilVersion.stdout.startsWith('ARKITEKT_PDF_UTIL v1.0')) {
        stateValue.value = AsyncError(
          'The Scripts are not working on your system '
          'contact developers for more details'
          '\n${ocrVersion.stderr}',
        );

        return false;
      }

      return true;
    } catch (e) {
      stateValue.value = AsyncError('Failed to check scripts, $e');
      return false;
    }
  }
}
