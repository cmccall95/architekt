import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/config/routes.dart';

class PreLoadPage extends StatefulWidget {
  const PreLoadPage({Key? key}) : super(key: key);

  @override
  _PreLoadPageState createState() => _PreLoadPageState();
}

class _PreLoadPageState extends State<PreLoadPage> {
  var message = 'Loading Libraries...';
  var downloadProgress = 0.0;
  var downloading = false;
  var error = '';

  @override
  void initState() {
    super.initState();

    checkPythonPresent();
  }

  @override
  Widget build(BuildContext context) {
    if (error.isNotEmpty) {
      return Material(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            TextButton(
              child: const Text('OK'),
              onPressed: () => exit(0),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ]),
        ),
      );
    } else {
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2,
              value: downloading ? downloadProgress : null,
            ),
            const SizedBox(height: 10),
            Text(message, style: const TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
  }

  void checkPythonPresent() async {
    final pythonResult = await Process.run('python', ['--version']);
    if (!pythonResult.stdout.toString().startsWith('Python')) {
      error = 'Python was not installed on your system, '
          'make sure you install Python before continuing';

      setState(() {});
    }

    final tesseractResult = await Process.run('tesseract', ['--version']);
    if (!tesseractResult.stdout.toString().startsWith('tesseract v5')) {
      error = 'Tesseract v5 was not installed on your system, '
          'make sure you install Tesseract v5 before continuing';

      setState(() {});
    }

    final directory = Directory(
      Directory.systemTemp.path + '\\' + 'arkitekt_ocr',
    );

    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    } else if (await Directory(directory.path + '\\arkitekt_ocr-master')
        .exists()) {
      if (await checkScripts()) {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(Routes.blueprint);

        return;
      }
    }

    setState(() {
      downloading = true;
      message = 'Downloading OCR Scripts (0%)';
    });
    await Dio().download(
        'https://github.com/ArishSultan/arkitekt_ocr/archive/refs/heads/master.zip',
        directory.path + '\\' + 'data.zip', onReceiveProgress: (c, t) {
      setState(() {
        downloadProgress = c / t;
        message = 'Downloading OCR Scripts (${(c / t * 100).round()}%)';
      });
    });
    setState(() {
      downloadProgress = 0;
      message = 'Unzipping OCR Scripts';
    });

    final bytes = await File(directory.path + '\\' + 'data.zip').readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File('${directory.path}/' + filename)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory('${directory.path}/' + filename).create(recursive: true);
      }
    }

    setState(() {
      downloading = false;
      message = 'Installing OCR Libraries';
    });
    final pipResult = await Process.run('pip', [
      'install',
      '-r',
      directory.path + '\\arkitekt_ocr-master\\requirements.txt'
    ]);

    if (!pipResult.stderr.toString().startsWith('WARNING')) {
      setState(() => error = pipResult.stderr.toString().toString());
    }

    if (await checkScripts()) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.blueprint);
    } else {
      setState(() {
        error = 'The Scripts are not working on your system '
            'contact developers for more details';
      });
    }
  }

  Future<bool> checkScripts() async {
    final path =
        Directory.systemTemp.path + '\\arkitekt_ocr\\arkitekt_ocr-master';

    final ocrResult = await Process.run(
      'python',
      ['$path\\main.py', '--version'],
    );

    if (!ocrResult.stdout.toString().startsWith('ARKITEKT_OCR v1.0')) {
      return false;
    }

    final pdfUtilResult = await Process.run(
      'python',
      ['$path\\pdf_utils.py', '--version'],
    );
    if (!pdfUtilResult.stdout.startsWith('ARKITEKT_PDF_UTIL v1.0')) {
      return false;
    }

    return true;
  }
}
