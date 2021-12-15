import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:arkitekt/src/components/blueprint_ocr_viewer.dart';

class BlueprintsReader extends StatefulWidget {
  const BlueprintsReader({Key? key}) : super(key: key);

  @override
  _BlueprintsReaderState createState() => _BlueprintsReaderState();
}

class _BlueprintsReaderState extends State<BlueprintsReader> {
  static final _ocr = '$_scriptDir\\main.py';
  static final _pdfUtil = '$_scriptDir\\pdf_utils.py';
  static final _mainDir = Directory.systemTemp.path + '\\arkitekt_ocr';
  static final _scriptDir =
      Directory.systemTemp.path + '\\arkitekt_ocr\\arkitekt_ocr-master';

  var page = 1;
  PdfDocument? document;
  PdfController? controller;

  bool get isFirst => page == 1;

  bool get isLast => document != null && page == document?.pagesCount;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (controller != null) {
      child = Row(children: [
        if (!isFirst)
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => controller?.previousPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 300),
              ),
              child: const Icon(Icons.chevron_left_rounded),
              style: TextButton.styleFrom(
                primary: Colors.grey.shade600,
                minimumSize: const Size(50, 50),
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        else
          const Padding(
            child: SizedBox(width: 50),
            padding: EdgeInsets.all(10),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: InteractiveViewer(
              child: PdfView(
                controller: controller!,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (newPage) => setState(() => page = newPage),
              ),
            ),
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => controller?.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 300),
              ),
              child: const Icon(Icons.chevron_right_rounded),
              style: TextButton.styleFrom(
                primary: Colors.grey.shade600,
                minimumSize: const Size(50, 50),
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        else
          const Padding(
            child: SizedBox(width: 50),
            padding: EdgeInsets.all(10),
          ),
      ]);
    } else {
      child = Container();
    }

    return Scaffold(
      body: child,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Blueprints Reader'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text(
                      'Are you sure?\n\nIf you press yes then application'
                      ' will close and you will have to manually restart the app',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Directory(_mainDir).deleteSync(recursive: true);
                          exit(0);
                        },
                        child: const Text('Yes'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      )
                    ],
                  );
                },
              );
            },
            label: const Text('Update Scripts'),
            icon: const Icon(Icons.update_rounded),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
          TextButton.icon(
            onPressed: () async {
              final pdf = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: const ['pdf'],
              );

              if (pdf != null) {
                document = await PdfDocument.openFile(pdf.paths.first!);

                if (controller != null) {
                  await controller!.loadDocument(Future.value(document));
                } else {
                  controller = PdfController(document: Future.value(document));
                }

                page = 1;
                setState(() {});
              }
            },
            label: const Text('Pick File'),
            icon: const Icon(Icons.upload_rounded),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          if (document != null)
            Center(
              child: Text(
                'page $page of ${document!.pagesCount}',
              ),
            ),
          const Spacer(),
          TextButton.icon(
            onPressed: handleButtonTap,
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('Apply OCR'),
            ),
            icon: const Icon(Icons.auto_fix_high_rounded),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void handleButtonTap() async {
    if (document == null) return;

    _showLoadingDialog();
    final dirName = Directory.systemTemp.path +
        '/' +
        DateTime.now().microsecondsSinceEpoch.toString();

    try {
      var result = await Process.run('python', [
        _pdfUtil,
        document!.sourceName.substring(5),
        page.toString(),
        (page + 1).toString(),
        dirName,
      ]);

      result = await Process.run('python', [
        _ocr,
        '$dirName/${page}_1.png',
        '$dirName/output.json',
      ]);

      final image = await File('$dirName/${page}_1.png').readAsBytes();
      final output =
          jsonDecode(await File('$dirName/output.json').readAsString());

      await Directory(dirName).delete(recursive: true);
      Navigator.of(context)
        ..pop()
        ..push(MaterialPageRoute(
          builder: (context) => BlueprintOcrViewer(
            page: page,
            data: output,
            image: image,
            pdfName: document!.sourceName.split('\\').last,
          ),
        ));
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  void _showLoadingDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 20),
              Text('Applying OCR to page $page')
            ]),
          ),
        );
      },
    );
  }
}
