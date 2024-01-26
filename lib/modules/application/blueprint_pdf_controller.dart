import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

class BlueprintPdfController {
  final pdfController = Rxn<PdfController>();
  final document = Rxn<File>();
  final page = 1.obs;

  bool get isFirstPage => page.value == 1;
  bool get isLastPage => page.value == pdfController.value?.pagesCount;

  Future<void> previousPage() async {
    if (isFirstPage) return;
    page.value--;
    await pdfController.value?.previousPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> nextPage() async {
    if (isLastPage) return;
    page.value++;
    await pdfController.value?.nextPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> pickDocument() async {
    final pdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );

    if (pdf == null) {
      return;
    }

    document.value = File(pdf.paths.first!);
    if (pdfController.value != null) {
      final document = PdfDocument.openFile(pdf.paths.first!);
      await pdfController.value!.loadDocument(document);
    } else {
      final document = PdfDocument.openFile(pdf.paths.first!);
      pdfController.value = PdfController(document: document);
    }

    page.value = 1;
  }
}
