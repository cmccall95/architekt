import 'package:arkitekt/modules/application/generate_m_t_o_grouped_controller.dart';
import 'package:arkitekt/modules/application/get_m_t_os_grouped_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../application/edit_table_row_controller.dart';
import '../../../application/get_m_t_os_controller.dart';
import '../../../application/map_json_to_database_controller.dart';
import '../../../application/update_m_t_o_controller.dart';
import '../../../domain/m_t_o.dart';
import '../../../domain/m_t_o_fields.dart';
import '../../widgets/async_helper.dart';
import '../../widgets/table_custom.dart';
import 'data.dart';

part 'widgets/_json_processing.dart';
part 'widgets/_m_t_o_tab.dart';
part 'widgets/_m_t_o_grouped_tab.dart';
part 'widgets/_table_tabs.dart';
part 'widgets/_m_t_o_group_processing.dart';

class MTOTablePage extends StatefulWidget {
  const MTOTablePage({super.key});

  @override
  State<MTOTablePage> createState() => _MTOTablePageState();
}

class _MTOTablePageState extends State<MTOTablePage> {
  late final Worker _everUpdateMTO;

  @override
  void initState() {
    super.initState();

    _everUpdateMTO = ever(
      Get.find<UpdateMTOController>().stateValue,
      (_) {
        final mto = Get.find<UpdateMTOController>().value;
        if (mto != null) {
          Get.find<GetMTOsController>().updateMTO(mto);
        }
      },
    );

    Get.find<MapJsonToDatabaseController>().mapJsonToDatabase(jsonData);
  }

  @override
  void dispose() {
    _everUpdateMTO.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncHelper(
      errorObservers: [
        Get.find<UpdateMTOController>().stateValue,
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('MTO Table'),
        ),
        body: const _JsonProcessing(),
      ),
    );
  }
}
