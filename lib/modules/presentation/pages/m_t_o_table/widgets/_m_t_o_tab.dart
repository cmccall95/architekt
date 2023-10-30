part of '../m_t_o_table_page.dart';

class _MTOTab extends StatelessWidget {
  const _MTOTab({super.key});

  void _onLoadMore() {
    final controller = Get.find<GetMTOsController>();
    if (controller.isLastPage.value) {
      return;
    }

    if (controller.paginationState.isLoading) {
      return;
    }

    controller.fetchNextBatch();
  }

  @override
  Widget build(BuildContext context) {
    const columns = MTOField.values;
    return TableCustom(
      headerBuilder: (horizontalScrollController) {
        return Obx(() {
          final controller = Get.find<GetMTOsController>();

          return TableCustomHeader(
            horizontalScrollController: horizontalScrollController,
            columns: columns,
            sort: controller.orderBy.value,
            onSort: (orderBy) {
              controller.orderBy.value = orderBy;
              controller.fetchFirstBatch();
            },
          );
        });
      },
      bodyBuilder: (horizontalScrollController) {
        return Obx(() {
          final state = Get.find<GetMTOsController>().stateValue;
          if (state.value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.value.hasError) {
            return Center(
              child: Text(state.value.asError.message),
            );
          }

          final data = state.value.asData.data ?? [];
          if (data.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }

          return TableCustomBody(
            horizontalScrollController: horizontalScrollController,
            rows: data,
            columns: columns,
            onLoadMore: _onLoadMore,
            isLastPage: Get.find<GetMTOsController>().isLastPage.value,
            cellBuilder: (mto, column) {
              return _MTOTableCell(
                row: mto,
                column: column,
              );
            },
          );
        });
      },
    );
  }
}

class _MTOTableCell extends StatelessWidget {
  const _MTOTableCell({
    required this.row,
    required this.column,
  });

  final MTO row;
  final MTOField column;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final value = row.getValueFromField(column);
      final selectedRow = Get.find<EditTableRowController>().row.value;
      final selectedColumn = Get.find<EditTableRowController>().column.value;

      final isSameRow = selectedRow?.databaseId == row.databaseId;
      final isSameColumn = selectedColumn?.value == column.value;

      final isSelected = isSameRow && isSameColumn;

      return TableCustomCell(
        onTap: () {
          MTO? row_ = row;
          MTOField? column_ = column;

          if (isSelected) {
            row_ = null;
            column_ = null;
          }

          Get.find<EditTableRowController>().row.value = row_;
          Get.find<EditTableRowController>().column.value = column_;
        },
        isSelected: isSelected,
        child: Text(value ?? '-'),
      );
    });
  }
}
