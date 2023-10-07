import 'package:arkitekt/core/config/routes.dart';
import 'package:arkitekt/core/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/components/pre_load_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const PreLoadPage(),
      getPages: Routes.pages,
    );
  }
}
