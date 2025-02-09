import 'package:get/get.dart';

import '../../modules/presentation/pages/blueprint/blueprint_page.dart';
import '../../modules/presentation/pages/m_t_o_table/m_t_o_table_page.dart';

abstract class Routes {
  static const blueprint = '/blueprint';
  static const mtoTable = '/mto-table';
  static const loadScripts = '/load-scripts';

  static List<GetPage> pages = [
    GetPage(
      name: blueprint,
      page: () => const BlueprintPage(),
    ),
    GetPage(
      name: mtoTable,
      page: () => const MTOTablePage(),
    ),
  ];
}
