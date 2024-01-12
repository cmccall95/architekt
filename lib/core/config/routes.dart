import 'package:get/get.dart';

import '../../modules/presentation/pages/blueprint/blueprint_bindings.dart';
import '../../modules/presentation/pages/blueprint/blueprint_page.dart';
import '../../modules/presentation/pages/load_scripts/load_scripts_bindings.dart';
import '../../modules/presentation/pages/load_scripts/load_scripts_page.dart';
import '../../modules/presentation/pages/m_t_o_table/m_t_o_table_bindings.dart';
import '../../modules/presentation/pages/m_t_o_table/m_t_o_table_page.dart';

abstract class Routes {
  static const blueprint = '/blueprint';
  static const mtoTable = '/mto-table';
  static const loadScripts = '/load-scripts';

  static List<GetPage> pages = [
    GetPage(
      name: blueprint,
      page: () => const BlueprintPage(),
      binding: BlueprintBindings(),
    ),
    GetPage(
      name: mtoTable,
      page: () => const MTOTablePage(),
      binding: MTOTableBindings(),
    ),
    GetPage(
      name: loadScripts,
      page: () => const LoadScriptsPage(),
      binding: LoadScriptsBindings(),
    ),
  ];
}
