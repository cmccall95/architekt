import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/extensions/context.dart';
import '../../../application/export_excel_controller.dart';
import '../../../application/general_data_columns_controller.dart';
import '../../../application/get_general_data_controller.dart';
import '../../../application/get_mtos_controller.dart';
import '../../../application/mto_columns_controller.dart';
import '../../../domain/mto_columns.dart';
import '../../widgets/async_helper.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/table_custom.dart';

part 'widgets/_export_button.dart';
part 'widgets/_general_data_table.dart';
part 'widgets/_mto_table.dart';
part 'widgets/_tabs.dart';

class MTOTablePage extends StatelessWidget {
  const MTOTablePage({super.key});

  void _onExportData({
    required BuildContext context,
    required AsyncValue<File?> state,
  }) {
    switch (state) {
      case AsyncError(:final error):
        ErrorDialog.show(
          context: context,
          title: 'Failed to export',
          message: error.toString(),
        );

        return;

      case AsyncData(:final value):
        if (value == null) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exported successfully'),
          ),
        );

        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Consumer(builder: (context, ref, child) {
        ref.listen(
          exportExcelControllerProvider,
          (_, state) => _onExportData(
            context: context,
            state: state,
          ),
        );

        return AsyncHelper(
          loadingProviders: [exportExcelControllerProvider],
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('MTO Table'),
              actions: const [
                _ExportButton(),
                SizedBox(width: 12),
              ],
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
          ),
        );
      }),
    );
  }
}
