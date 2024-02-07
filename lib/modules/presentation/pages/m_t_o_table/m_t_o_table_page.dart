import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/general_data_columns_controller.dart';
import '../../../application/get_general_data_controller.dart';
import '../../../application/get_mtos_controller.dart';
import '../../../application/mto_columns_controller.dart';
import '../../../domain/mto_columns.dart';
import '../../widgets/table_custom.dart';

part 'widgets/_general_data_table.dart';
part 'widgets/_mto_table.dart';
part 'widgets/_tabs.dart';

class MTOTablePage extends StatelessWidget {
  const MTOTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTO Table'),
      ),
      body: const DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _MtoTable(),
                  SizedBox(),
                  _GeneralDataTable(),
                ],
              ),
            ),
            _Tabs(),
          ],
        ),
      ),
    );
  }
}
