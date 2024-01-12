import 'dart:io';

import 'package:arkitekt/core/config/routes.dart';
import 'package:arkitekt/core/utils/async_value.dart';
import 'package:arkitekt/modules/application/load_ocr_libraries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadScriptsPage extends StatefulWidget {
  const LoadScriptsPage({Key? key}) : super(key: key);

  @override
  State<LoadScriptsPage> createState() => _LoadScriptsPageState();
}

class _LoadScriptsPageState extends State<LoadScriptsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<LoadOcrLibraries>();
      controller.loadLibraries();
    });

    ever(Get.find<LoadOcrLibraries>().stateValue, (value) {
      switch (value) {
        case AsyncData():
          Get.offNamed(Routes.blueprint);
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          final controller = Get.find<LoadOcrLibraries>();
          final state = controller.state;

          switch (state) {
            case AsyncLoading(:final message, :final progress):
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    value: progress,
                  ),
                  if (message != null && message.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(message, style: const TextStyle(fontSize: 18)),
                  ],
                ],
              );
            case AsyncError(:final message):
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => exit(0),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('OK'),
                  ),
                ],
              );
            case AsyncData():
              return const Text('Redirecting...');
          }
        }),
      ),
    );
  }
}
