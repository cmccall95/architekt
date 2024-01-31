import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/logger_custom.dart';

part 'blueprint_pdf_controller.g.dart';

@riverpod
class BlueprintPdfController extends _$BlueprintPdfController {
  PdfController? pdfController;

  @override
  AsyncValue<PDFProperties?> build() {
    return const AsyncData(null);
  }

  Future<void> _loadFirstDocument(FilePickerResult pdf) async {
    state = const AsyncLoading();
    try {
      final document = PdfDocument.openFile(pdf.paths.first!);
      pdfController = PdfController(document: document);

      final document_ = await document;
      final page = await document_.getPage(1);

      final file = File(pdf.paths.first!);
      final width = page.width;
      final height = page.height;

      state = AsyncData(PDFProperties(
        file: file,
        width: width,
        height: height,
        pagesCount: document_.pagesCount,
        currentPage: 1,
      ));
    } catch (e, stack) {
      logger.e('Error loading document $e', stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> _loadNextDocument(FilePickerResult pdf) async {
    try {
      final document = PdfDocument.openFile(pdf.paths.first!);
      pdfController!.loadDocument(document);

      final document_ = await document;
      final page = await document_.getPage(1);

      final file = File(pdf.paths.first!);
      final width = page.width;
      final height = page.height;

      state = AsyncData(PDFProperties(
        file: file,
        width: width,
        height: height,
        pagesCount: document_.pagesCount,
        currentPage: 1,
      ));
    } catch (e, stack) {
      logger.e('Error loading document $e', stackTrace: stack);
      state = AsyncError(e, stack);
    }
  }

  Future<void> pickDocument() async {
    final pdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );

    if (pdf == null) {
      return;
    }

    if (pdfController == null) {
      await _loadFirstDocument(pdf);
    } else {
      await _loadNextDocument(pdf);
    }
  }

  Future<void> previousPage() async {
    if (state is! AsyncData || state.valueOrNull == null) {
      return;
    }

    final value = state.valueOrNull!;
    if (value.isFirstPage) return;

    state = AsyncData(value.copyWith(
      currentPage: value.currentPage - 1,
    ));

    await pdfController?.previousPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> nextPage() async {
    if (state is! AsyncData || state.valueOrNull == null) {
      return;
    }

    final value = state.valueOrNull!;
    if (value.isLastPage) return;

    state = AsyncData(value.copyWith(
      currentPage: value.currentPage + 1,
    ));

    await pdfController?.nextPage(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class PDFProperties {
  const PDFProperties({
    required this.file,
    required this.width,
    required this.height,
    required this.pagesCount,
    required this.currentPage,
  });

  final File file;
  final double width;
  final double height;
  final int pagesCount;
  final int currentPage;

  double get aspectRatio => width / height;
  bool get isFirstPage => currentPage == 1;
  bool get isLastPage => currentPage == pagesCount;

  PDFProperties copyWith({
    File? file,
    double? width,
    double? height,
    int? pagesCount,
    int? currentPage,
  }) {
    return PDFProperties(
      file: file ?? this.file,
      width: width ?? this.width,
      height: height ?? this.height,
      pagesCount: pagesCount ?? this.pagesCount,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
