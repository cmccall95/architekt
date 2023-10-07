import 'package:get/get.dart';

import '../../modules/presentation/pages/blueprint/blueprint_bindings.dart';
import '../../modules/presentation/pages/blueprint/blueprint_page.dart';

abstract class Routes {
  static const blueprint = '/blueprint';

  static List<GetPage> pages = [
    GetPage(
      name: blueprint,
      page: () => const BlueprintPage(),
      binding: BlueprintBindings(),
    ),
  ];
}
