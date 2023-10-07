import 'package:arkitekt/modules/application/blueprint_pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickDocumentButton extends StatelessWidget {
  const PickDocumentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          Get.find<BlueprintPdfController>().pickDocument();
        },
        label: const Text('Pick File'),
        icon: const Icon(Icons.upload_rounded),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
