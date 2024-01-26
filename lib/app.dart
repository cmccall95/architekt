import 'package:arkitekt/core/config/database_helper.dart';
import 'package:arkitekt/core/config/routes.dart';
import 'package:arkitekt/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.blueprint,
      getPages: Routes.pages,
      initialBinding: _InitialBindings(),
    );
  }
}

class _InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DatabaseHelper>(DatabaseHelper());
  }
}
