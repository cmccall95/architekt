import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../application/edit_table_row_controller.dart';
import '../../application/update_m_t_o_controller.dart';
import '../../domain/m_t_o.dart';
import '../../domain/m_t_o_fields.dart';

class TableFieldEditor extends StatelessWidget {
  const TableFieldEditor({super.key});

  void _updateField({
    required MTO mto,
    required MTOField column,
    required String value,
  }) {
    final controller = Get.find<UpdateMTOController>();
    final json = mto.toJson();
    json[column.value] = value;

    controller.updateMTO(MTO.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<EditTableRowController>();
      final column = controller.column.value;
      final row = controller.row.value;

      if (column == null) {
        return const SizedBox.shrink();
      }

      if (row == null) {
        return const SizedBox.shrink();
      }

      final key = '${row.databaseId}-${column.value}';
      return Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              '${column.name}:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                key: Key(key),
                initialValue: row.getValueFromField(column),
                onChanged: (value) {
                  _updateField(
                    mto: row,
                    column: column,
                    value: value,
                  );
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
