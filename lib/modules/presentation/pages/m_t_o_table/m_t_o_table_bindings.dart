import 'package:get/get.dart';

import '../../../application/edit_table_row_controller.dart';
import '../../../application/get_m_t_os_controller.dart';
import '../../../application/map_json_to_database_controller.dart';
import '../../../application/update_m_t_o_controller.dart';

class MTOTableBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetMTOsController());
    Get.lazyPut(() => UpdateMTOController());
    Get.lazyPut(() => EditTableRowController());
    Get.lazyPut(() => MapJsonToDatabaseController());
  }
}
